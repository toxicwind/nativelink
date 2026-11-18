// source.config.ts
import { defineDocs, defineConfig } from "fumadocs-mdx/config";
import { rehypeCodeDefaultOptions } from "fumadocs-core/mdx-plugins";
var docs = defineDocs({
  dir: "content/docs"
});
var source_config_default = defineConfig({
  mdxOptions: {
    rehypeCodeOptions: {
      ...rehypeCodeDefaultOptions,
      // Shiki has no `starlark` grammar. Starlark is a Python dialect, so load
      // Python and highlight `starlark` blocks (Bazel BUILD/.bzl) with it.
      langs: ["python"],
      langAlias: {
        starlark: "python"
      }
    }
  }
});
export {
  source_config_default as default,
  docs
};
