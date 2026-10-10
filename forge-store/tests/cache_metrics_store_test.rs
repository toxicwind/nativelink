// Copyright 2026 The Forge Authors. All rights reserved.
//
// Licensed under the Functional Source License, Version 1.1, Apache 2.0 Future License (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    See LICENSE file for details
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

use std::sync::Arc;

use forge_config::stores::{CacheMetricsSpec, MemorySpec, StoreSpec};
use forge_error::{Code, Error};
use forge_macro::forge_test;
use forge_store::cache_metrics_store::CacheMetricsStore;
use forge_store::default_store_factory::store_factory;
use forge_store::store_manager::StoreManager;
use forge_util::common::DigestInfo;
use forge_util::store_trait::StoreLike;
use pretty_assertions::assert_eq;

const VALID_HASH: &str = "0123456789abcdef000000000000000000010000000000000123456789abcdef";
const MISSING_HASH: &str = "0123456789abcdef000000000000000000020000000000000123456789abcdef";

#[forge_test]
async fn cache_metrics_store_is_only_constructed_when_configured() -> Result<(), Error> {
    let store_manager = Arc::new(StoreManager::new());

    let plain_store = store_factory(
        &StoreSpec::Memory(MemorySpec::default()),
        &store_manager,
        None,
    )
    .await?;
    assert!(
        plain_store
            .downcast_ref::<CacheMetricsStore>(None)
            .is_none(),
        "plain memory store should not be wrapped with cache metrics"
    );

    let wrapped_store = store_factory(
        &StoreSpec::CacheMetrics(Box::new(CacheMetricsSpec {
            cache_type: "cas".to_string(),
            backend: StoreSpec::Memory(MemorySpec::default()),
        })),
        &store_manager,
        None,
    )
    .await?;
    assert!(
        wrapped_store
            .downcast_ref::<CacheMetricsStore>(None)
            .is_some(),
        "cache_metrics config should construct the metrics wrapper"
    );

    Ok(())
}

#[forge_test]
async fn cache_metrics_store_preserves_backend_store_semantics() -> Result<(), Error> {
    let store_manager = Arc::new(StoreManager::new());
    let store = store_factory(
        &StoreSpec::CacheMetrics(Box::new(CacheMetricsSpec {
            cache_type: "cas".to_string(),
            backend: StoreSpec::Memory(MemorySpec::default()),
        })),
        &store_manager,
        None,
    )
    .await?;

    let value = "cache metrics payload";
    let digest = DigestInfo::try_new(VALID_HASH, value.len())?;
    store.update_oneshot(digest, value.into()).await?;

    assert_eq!(store.has(digest).await?, Some(value.len() as u64));
    assert_eq!(
        store.get_part_unchunked(digest, 0, None).await?,
        value.as_bytes()
    );

    let missing_digest = DigestInfo::try_new(MISSING_HASH, value.len())?;
    let missing = store.get_part_unchunked(missing_digest, 0, None).await;
    assert_eq!(missing.unwrap_err().code, Code::NotFound);

    Ok(())
}
