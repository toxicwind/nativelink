1:"$Sreact.fragment"
2:T982,text-[1.0625rem] leading-[1.75] text-muted-foreground [&_h1]:mb-6 [&_h1]:text-4xl [&_h1]:font-semibold [&_h1]:leading-[1.15] [&_h1]:tracking-[-0.025em] [&_h1]:text-foreground [&_h2]:mt-12 [&_h2]:mb-4 [&_h2]:text-[1.6rem] [&_h2]:font-semibold [&_h2]:leading-[1.25] [&_h2]:tracking-[-0.02em] [&_h2]:text-foreground [&_h3]:mt-9 [&_h3]:mb-3 [&_h3]:text-xl [&_h3]:font-semibold [&_h3]:leading-[1.3] [&_h3]:text-foreground [&_h4]:mt-8 [&_h4]:mb-2 [&_h4]:text-lg [&_h4]:font-semibold [&_h4]:text-foreground [&_p]:my-[1.15em] [&_strong]:font-semibold [&_strong]:text-foreground [&_a]:font-medium [&_a]:text-brand [&_a]:underline [&_a]:underline-offset-4 hover:[&_a]:text-brand-strong [&_ul]:my-[1.15em] [&_ul]:list-disc [&_ul]:pl-6 [&_ol]:my-[1.15em] [&_ol]:list-decimal [&_ol]:pl-6 [&_li]:my-1.5 [&_li]:pl-1 [&_blockquote]:my-8 [&_blockquote]:border-l-2 [&_blockquote]:border-brand/50 [&_blockquote]:pl-6 [&_blockquote]:text-foreground [&_blockquote_p]:my-0 [&_blockquote_p:first-of-type]:text-[1.5rem] [&_blockquote_p:first-of-type]:leading-[1.3] [&_blockquote_p:first-of-type]:font-medium [&_blockquote_p:first-of-type]:tracking-[-0.02em] md:[&_blockquote_p:first-of-type]:text-[1.75rem] [&_blockquote_p:not(:first-of-type)]:mt-3 [&_blockquote_p:not(:first-of-type)]:text-[0.95rem] [&_blockquote_p:not(:first-of-type)]:font-normal [&_blockquote_p:not(:first-of-type)]:leading-normal [&_blockquote_p:not(:first-of-type)]:tracking-normal [&_blockquote_p:not(:first-of-type)]:text-muted-foreground [&_blockquote_p:not(:first-of-type)]:not-italic [&_table]:my-6 [&_table]:w-full [&_table]:border-collapse [&_table]:text-[0.95em] [&_th]:border-b [&_th]:border-border [&_th]:py-2.5 [&_th]:pr-4 [&_th]:text-left [&_th]:font-semibold [&_th]:text-foreground [&_td]:border-b [&_td]:border-border/60 [&_td]:py-2.5 [&_td]:pr-4 [&_td]:align-top [&_tr:last-child_td]:border-b-0 [&_img]:my-8 [&_img]:rounded-xl [&_hr]:my-10 [&_hr]:border-border/60 [&_code]:rounded [&_code]:bg-foreground/5 [&_code]:px-1.5 [&_code]:py-0.5 [&_code]:font-mono [&_code]:text-[0.875em] [&_pre]:my-6 [&_pre]:overflow-x-auto [&_pre]:rounded-lg [&_pre]:border [&_pre]:border-border [&_pre]:bg-foreground/[0.03] [&_pre]:p-4 [&_pre]:font-mono [&_pre]:text-sm [&_pre]:leading-relaxed [&_pre_code]:bg-transparent [&_pre_code]:p-0 [&_pre_code]:text-inherit blog-prose max-w-none [&_img:not(.glance-logo)]:my-6 [&_img:not(.glance-logo)]:max-w-full [&_img:not(.glance-logo)]:rounded-xl3:T207a,<h2>Supercharge Your C/C++ Builds without Migrating to Bazel: A Tutorial for CMake Acceleration with Forge and BuildStream</h2>
<p>Slow build times can be a major drag on developer productivity. Waiting for your code to compile and build can interrupt your flow and waste valuable time. Lots of companies have moved to Bazel and Buck2 to deal with this issue. But for many companies that investment in migrating to Bazel is too risky or too costly. What if you could accelerate your C/C++ projects using CMake? This tutorial will guide you through setting up a blazing-fast build environment using <a href="https://github.com/toxicwind/forge">Forge</a> and <a href="https://buildstream.build/">Apache BuildStream</a> for remote caching and execution. We&#39;ll walk through a &quot;hello, world&quot; example to get you up and running in under 15 minutes.</p>
<hr>
<h3>What are Forge and Apache BuildStream?</h3>
<ul>
<li><strong>BuildStream</strong> is a flexible and extensible tool for building and integrating software stacks. It creates a sandbox environment for your builds, ensuring they&#39;re reproducible and isolated.</li>
<li><strong>Forge</strong> is a high-performance remote execution and caching service that&#39;s compatible with the Remote Execution API (REAPI). It acts as a server to store and retrieve build artifacts, and to execute build tasks on remote workers.</li>
</ul>
<p>By using them together, you can distribute your build jobs and cache their results, leading to significant speedups, especially in large projects.</p>
<hr>
<h3>Project Setup</h3>
<p>Let&#39;s start by setting up our project directory. We&#39;ll create a structure to hold our source code, Makefile, and BuildStream configuration.</p>
<pre><code class="language-bash">mkdir -p first-project/elements/base first-project/files/src
cd first-project
</code></pre>
<p>Your directory structure should look like this:</p>
<pre><code class="language-shell">first-project/
├── elements/
│   └── base/
│
└── files/
    └── src/
</code></pre>
<hr>
<h3>The &quot;Hello, World&quot; Application</h3>
<p>Next, let&#39;s create our C application and the corresponding Makefile.</p>
<h4><code>hello.c</code></h4>
<p>Create a file named <code>hello.c</code> inside the <code>files/src</code> directory:</p>
<pre><code class="language-c">/*
 * hello.c - a hello world program
 */
#include &lt;stdio.h&gt;

int main(int argc, char *argv[])
{
  printf(&quot;Hello World\n&quot;);
  return 0;
}
</code></pre>
<h4><code>Makefile</code></h4>
<p>Now, create a <code>Makefile</code> in the same <code>files/src</code> directory:</p>
<pre><code class="language-makefile">.PHONY: all

all: hello
hello: hello.c
	$(CC) -Wall -o $@ $&lt;
</code></pre>
<hr>
<h3>Configuring BuildStream</h3>
<p>Now, let&#39;s configure BuildStream to build our project.</p>
<h4><code>project.conf</code></h4>
<p>First, create a <code>project.conf</code> file in the root of your <code>first-project</code> directory. This file defines the basic properties of your project.</p>
<pre><code class="language-shell"># Unique project name
name: first-project

# Required BuildStream version
min-version: 2.4

# Subdirectory where elements are stored
element-path: elements

# Define an alias for our alpine tarball
aliases:
  alpine: https://bst-integration-test-images.ams3.cdn.digitaloceanspaces.com/
</code></pre>
<h4><code>elements/base/alpine.bst</code></h4>
<p>Next, we need to define our base system. We&#39;ll use a pre-built, trimmed-down Alpine Linux image. Create <code>elements/base/alpine.bst</code>:</p>
<pre><code class="language-yaml">kind: import
description: |

    Alpine Linux base runtime

sources:
- kind: tar
  # This is a post doctored, trimmed down system image
  # of the Alpine linux distribution.
  #
  url: alpine:integration-tests-base.v1.x86_64.tar.xz
  ref: 3eb559250ba82b64a68d86d0636a6b127aa5f6d25d3601a79f79214dc9703639
</code></pre>
<h4><code>elements/base.bst</code></h4>
<p>Now, create a <code>elements/base.bst</code> file to create a stack with the Alpine base:</p>
<pre><code class="language-yaml">kind: stack
description: Base stack

depends:
- base/alpine.bst
</code></pre>
<p>####<code>elements/hello.bst</code></p>
<p>Finally, create the element for our &quot;hello, world&quot; application in <code>elements/hello.bst</code>. This element specifies how to build our application.</p>
<pre><code class="language-yaml">kind: manual
description: |

  Building manually

# Depend on the base system
depends:
- base.bst

# Stage the files/src directory for building
sources:
  - kind: local
    path: files/src

# Now configure the commands to run
config:

  build-commands:
  - make hello
</code></pre>
<hr>
<h3>Configuring Forge for Remote Caching &amp; Execution</h3>
<p>With our project set up, it&#39;s time to bring in Forge to accelerate the build.</p>
<h4><code>buildstream.conf</code></h4>
<p>To tell BuildStream to use a remote execution service, create a <code>buildstream.conf</code> file in your project&#39;s root directory:</p>
<pre><code class="language-yaml">cachedir: /tmp/buildstream

artifacts:
  servers:
  - url: http://localhost:50051
    push: true
remote-execution:
  execution-service:
    url: http://localhost:50051
  action-cache-service:
    url: http://localhost:50051
  storage-service:
    url: http://localhost:50051
</code></pre>
<p>This configuration tells BuildStream to connect to a Forge instance running on <code>localhost:50051</code> for artifact caching and remote execution.</p>
<hr>
<h3>Running the Build</h3>
<p>We&#39;ll use a script to launch the Forge service and then run the BuildStream build. The example below uses Nix to manage the dependencies, but you can adapt it to your environment.</p>
<h4>Launch Script</h4>
<p>Here is an example script, similar to <code>buildstream-with-forge-test.nix</code>, that shows how to run the build.</p>
<pre><code class="language-nix">{
  forge,
  buildstream,
  buildbox,
  writeShellScriptBin,
}:
writeShellScriptBin &quot;buildstream-with-forge-test&quot; &#39;&#39;
  set -uo pipefail

  cleanup() {
    local pids=$(jobs -pr)
    [ -n &quot;$pids&quot; ] &amp;&amp; kill $pids
  }
  trap &quot;cleanup&quot; INT QUIT TERM EXIT

  ${forge}/bin/forge -- integration_tests/buildstream/buildstream_cas.json5 | tee -i integration_tests/buildstream/forge.log &amp;

  # TODO(palfrey): PATH is workaround for https://github.com/NixOS/nixpkgs/issues/248000#issuecomment-2934704963
  bst_output=$(cd integration_tests/buildstream &amp;&amp; PATH=${buildbox}/bin:$PATH ${buildstream}/bin/bst -c buildstream.conf build hello.bst 2&gt;&amp;1 | tee -i buildstream.log)

  case $bst_output in
    *&quot;SUCCESS Build&quot;* )
      echo &quot;Saw a successful buildstream build&quot;
    ;;
    *)
      echo &#39;Failed buildstream build:&#39;
      echo $bst_output
      exit 1
    ;;
  esac

  forge_output=$(cat integration_tests/buildstream/forge.log)

  case $forge_output in
    *&quot;ERROR&quot;* )
      echo &quot;Error in forge build&quot;
      exit 1
    ;;
    *)
      echo &#39;Successful forge build&#39;
    ;;
  esac
&#39;&#39;
</code></pre>
<p>To run the build, you would execute this script. It first starts the <code>forge</code> service in the background, then runs <code>bst build</code>.</p>
<p>The first time you run the build, it will compile the code and store the result in the Forge cache. Subsequent builds will be significantly faster as the results will be fetched directly from the cache, skipping the compilation step entirely.</p>
<hr>
<h3>Conclusion</h3>
<p>You have now successfully set up a project with BuildStream and Forge for accelerated builds with code pulled directly from Forge&#39;s production <a href="https://github.com/toxicwind/forge/tree/main/integration_tests/buildstream">integration tests</a>. By leveraging remote caching and execution, you can dramatically reduce build times, especially for larger and more complex projects. This allows you to iterate faster and stay in the creative flow. Finally, developers and managers alike can appreciate a developer productivity tool!</p>
<p>If you have any questions or want to learn more, feel free to reach out to <strong><a href="mailto:contact@forge.com">contact@forge.com</a></strong>. Happy building! 🚀</p>
7:X
c:X
c:C
0:{"buildId":"KOFMzPd7o5DOrtfpDCIcw","data":[{"rsc":["$","$1","c",{"children":[[["$","section",null,{"className":"relative overflow-hidden","children":[["$","div",null,{"className":"pointer-events-none absolute inset-x-0 top-0 -z-10 h-[400px] bg-[radial-gradient(ellipse_900px_400px_at_50%_-10%,rgb(var(--nl-color-brand)/0.10),transparent_70%)]"}],["$","section",null,{"className":"relative px-6 py-20 pt-24 pb-6 md:pt-32 md:pb-8","children":["$","div",null,{"className":"mx-auto w-full max-w-[1200px]","children":["$","div",null,{"className":"mx-auto max-w-[760px]","children":[["$","a",null,{"href":"/resources/blog","className":"font-mono text-sm text-brand transition-colors hover:text-foreground","children":"← All posts"}],["$","div",null,{"className":"mt-8 flex flex-wrap items-center gap-2","children":[["$","span","tutorial",{"className":"inline-flex items-center gap-1.5 rounded-full border px-2.5 py-1 font-mono text-[11px] uppercase tracking-[0.12em] leading-none border-border-strong bg-transparent text-foreground","children":"tutorial"}],["$","span","cmake",{"className":"inline-flex items-center gap-1.5 rounded-full border px-2.5 py-1 font-mono text-[11px] uppercase tracking-[0.12em] leading-none border-border-strong bg-transparent text-foreground","children":"cmake"}],["$","span","build-acceleration",{"className":"inline-flex items-center gap-1.5 rounded-full border px-2.5 py-1 font-mono text-[11px] uppercase tracking-[0.12em] leading-none border-border-strong bg-transparent text-foreground","children":"build-acceleration"}],["$","span","blog-posts",{"className":"inline-flex items-center gap-1.5 rounded-full border px-2.5 py-1 font-mono text-[11px] uppercase tracking-[0.12em] leading-none border-border-strong bg-transparent text-foreground","children":"blog-posts"}]]}],["$","h1",null,{"className":"mt-5 text-balance text-[32px] font-semibold leading-[1.12] tracking-[-0.03em] md:text-[42px]","children":"Supercharge Your C/C++ Builds without Migrating to Bazel: A Tutorial for CMake, Forge and BuildStream"}],["$","p",null,{"className":"mt-4 font-mono text-xs tracking-wide text-muted","children":["August 12, 2025"," · 8 minutes"]}]]}]}]}]]}],["$","section",null,{"className":"relative px-6 py-20 pt-2 pb-28 md:pt-0","children":["$","div",null,{"className":"mx-auto w-full max-w-[1200px]","children":["$","div",null,{"className":"mx-auto max-w-[760px]","children":[["$","div",null,{"className":"$2","dangerouslySetInnerHTML":{"__html":"$3"}}],"$L4"]}]}]}]],null,"$L5"]}],"isPartial":"$@6","staleTime":"$7","varyParams":null},{"rsc":"$L8","isPartial":"$@9","staleTime":"$7","varyParams":null},{"rsc":"$La","isPartial":"$@b","staleTime":"$7","varyParams":"$c"},{"rsc":"$Ld","isPartial":"$@e","staleTime":"$7","varyParams":"$c"},{"rsc":"$Lf","isPartial":"$@10","staleTime":"$7","varyParams":"$c"}],"isUpgradeableISRFallback":false,"a":"$@11","rootVaryParams":null,"needsRuntimeRequest":"$@12"}
13:I[97367,["/_next/static/chunks/0h2qsuyze9ds1.js"],"OutletBoundary"]
14:"$Sreact.suspense"
16:I[97367,["/_next/static/chunks/0h2qsuyze9ds1.js"],"ViewportBoundary"]
17:I[97367,["/_next/static/chunks/0h2qsuyze9ds1.js"],"MetadataBoundary"]
18:I[27201,["/_next/static/chunks/0h2qsuyze9ds1.js"],"IconMark"]
19:I[39756,["/_next/static/chunks/0h2qsuyze9ds1.js"],"default"]
1a:I[37457,["/_next/static/chunks/0h2qsuyze9ds1.js"],"default"]
4:["$","div",null,{"className":"mt-16 border-t border-border pt-8","children":[["$","p",null,{"className":"font-mono uppercase tracking-[0.18em] text-muted text-[10px]","children":"Forge Blog"}],["$","p",null,{"className":"mt-3 text-sm text-muted-foreground","children":["$","a",null,{"href":"/resources/blog","className":"text-brand transition-colors hover:text-foreground","children":"← Back to all posts"}]}]]}]
5:["$","$L13",null,{"children":["$","$14",null,{"name":"Next.MetadataOutlet","children":"$@15"}]}]
8:["$","$1","h",{"children":[null,["$","$L16",null,{"children":[["$","meta","0",{"charSet":"utf-8"}],["$","meta","1",{"name":"viewport","content":"width=device-width, initial-scale=1"}]]}],["$","div",null,{"hidden":true,"children":["$","$L17",null,{"children":["$","$14",null,{"name":"Next.Metadata","children":[["$","title","0",{"children":"Supercharge Your C/C++ Builds without Migrating to Bazel: A Tutorial for CMake, Forge and BuildStream — Forge"}],["$","meta","1",{"name":"description","content":"Slow build times can be a major drag on developer productivity. Waiting for your code to compile and build can interrupt your flow and waste valuable time. Lots of companies have moved to Bazel and…"}],["$","meta","2",{"property":"og:title","content":"Supercharge Your C/C++ Builds without Migrating to Bazel: A Tutorial for CMake, Forge and BuildStream"}],["$","meta","3",{"property":"og:description","content":"Slow build times can be a major drag on developer productivity. Waiting for your code to compile and build can interrupt your flow and waste valuable time. Lots of companies have moved to Bazel and…"}],["$","meta","4",{"property":"og:image","content":"https://forge-cdn.s3.us-east-1.amazonaws.com/forge_logo.webp"}],["$","meta","5",{"property":"og:type","content":"article"}],["$","meta","6",{"name":"twitter:card","content":"summary_large_image"}],["$","meta","7",{"name":"twitter:title","content":"Supercharge Your C/C++ Builds without Migrating to Bazel: A Tutorial for CMake, Forge and BuildStream"}],["$","meta","8",{"name":"twitter:description","content":"Slow build times can be a major drag on developer productivity. Waiting for your code to compile and build can interrupt your flow and waste valuable time. Lots of companies have moved to Bazel and…"}],["$","meta","9",{"name":"twitter:image","content":"https://forge-cdn.s3.us-east-1.amazonaws.com/forge_logo.webp"}],["$","link","10",{"rel":"icon","href":"/icon.svg?icon.1u05eo7bsa_k9.svg","sizes":"any","type":"image/svg+xml"}],["$","$L18","11",{}]]}]}]}],["$","meta",null,{"name":"next-size-adjust","content":""}]]}]
a:["$","$1","c",{"children":[null,["$","$L19",null,{"parallelRouterKey":"children","template":["$","$L1a",null,{}]}]]}]
d:["$","$1","c",{"children":[null,["$","$L19",null,{"parallelRouterKey":"children","template":["$","$L1a",null,{}]}]]}]
f:["$","$1","c",{"children":[null,["$","$L19",null,{"parallelRouterKey":"children","template":["$","$L1a",null,{}]}]]}]
12:true
15:null
7:300
7:C
11:0
9:"$undefined"
b:"$undefined"
e:"$undefined"
10:"$undefined"
6:"$undefined"
