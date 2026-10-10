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

//! ```sh
//! cargo run --bin build-schema --features dev-schema --package forge-config
//! ```

#[cfg(feature = "dev-schema")]
fn main() {
    use std::fs::File;

    use forge_config::cas_server::CasConfig;
    use schemars::schema_for;
    use serde_json::to_writer_pretty;
    const FILE: &str = "forge_config.schema.json";

    let schema = schema_for!(CasConfig);
    to_writer_pretty(File::create(FILE).expect("to create file"), &schema)
        .expect("to export schema");

    println!("Wrote schema to {FILE}");
}

#[cfg(not(feature = "dev-schema"))]
fn main() {
    eprintln!("Enable with --features dev-schema");
}
