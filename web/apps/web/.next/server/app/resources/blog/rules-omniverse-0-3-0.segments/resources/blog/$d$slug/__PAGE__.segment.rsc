1:"$Sreact.fragment"
2:T982,text-[1.0625rem] leading-[1.75] text-muted-foreground [&_h1]:mb-6 [&_h1]:text-4xl [&_h1]:font-semibold [&_h1]:leading-[1.15] [&_h1]:tracking-[-0.025em] [&_h1]:text-foreground [&_h2]:mt-12 [&_h2]:mb-4 [&_h2]:text-[1.6rem] [&_h2]:font-semibold [&_h2]:leading-[1.25] [&_h2]:tracking-[-0.02em] [&_h2]:text-foreground [&_h3]:mt-9 [&_h3]:mb-3 [&_h3]:text-xl [&_h3]:font-semibold [&_h3]:leading-[1.3] [&_h3]:text-foreground [&_h4]:mt-8 [&_h4]:mb-2 [&_h4]:text-lg [&_h4]:font-semibold [&_h4]:text-foreground [&_p]:my-[1.15em] [&_strong]:font-semibold [&_strong]:text-foreground [&_a]:font-medium [&_a]:text-brand [&_a]:underline [&_a]:underline-offset-4 hover:[&_a]:text-brand-strong [&_ul]:my-[1.15em] [&_ul]:list-disc [&_ul]:pl-6 [&_ol]:my-[1.15em] [&_ol]:list-decimal [&_ol]:pl-6 [&_li]:my-1.5 [&_li]:pl-1 [&_blockquote]:my-8 [&_blockquote]:border-l-2 [&_blockquote]:border-brand/50 [&_blockquote]:pl-6 [&_blockquote]:text-foreground [&_blockquote_p]:my-0 [&_blockquote_p:first-of-type]:text-[1.5rem] [&_blockquote_p:first-of-type]:leading-[1.3] [&_blockquote_p:first-of-type]:font-medium [&_blockquote_p:first-of-type]:tracking-[-0.02em] md:[&_blockquote_p:first-of-type]:text-[1.75rem] [&_blockquote_p:not(:first-of-type)]:mt-3 [&_blockquote_p:not(:first-of-type)]:text-[0.95rem] [&_blockquote_p:not(:first-of-type)]:font-normal [&_blockquote_p:not(:first-of-type)]:leading-normal [&_blockquote_p:not(:first-of-type)]:tracking-normal [&_blockquote_p:not(:first-of-type)]:text-muted-foreground [&_blockquote_p:not(:first-of-type)]:not-italic [&_table]:my-6 [&_table]:w-full [&_table]:border-collapse [&_table]:text-[0.95em] [&_th]:border-b [&_th]:border-border [&_th]:py-2.5 [&_th]:pr-4 [&_th]:text-left [&_th]:font-semibold [&_th]:text-foreground [&_td]:border-b [&_td]:border-border/60 [&_td]:py-2.5 [&_td]:pr-4 [&_td]:align-top [&_tr:last-child_td]:border-b-0 [&_img]:my-8 [&_img]:rounded-xl [&_hr]:my-10 [&_hr]:border-border/60 [&_code]:rounded [&_code]:bg-foreground/5 [&_code]:px-1.5 [&_code]:py-0.5 [&_code]:font-mono [&_code]:text-[0.875em] [&_pre]:my-6 [&_pre]:overflow-x-auto [&_pre]:rounded-lg [&_pre]:border [&_pre]:border-border [&_pre]:bg-foreground/[0.03] [&_pre]:p-4 [&_pre]:font-mono [&_pre]:text-sm [&_pre]:leading-relaxed [&_pre_code]:bg-transparent [&_pre_code]:p-0 [&_pre_code]:text-inherit blog-prose max-w-none [&_img:not(.glance-logo)]:my-6 [&_img:not(.glance-logo)]:max-w-full [&_img:not(.glance-logo)]:rounded-xl3:T2c67,<p>Today we are releasing our first official Bazel ruleset for physical AI. It is
built to carry robotics work from research to production.</p>
<p><a href="https://github.com/TraceMachina/rules_omniverse/tree/v0.3.0"><code>rules_omniverse</code> 0.3.0</a>
has one goal: help robotics and software teams work together with the same
tools, lower costs, and move faster. This is one of many steps Trace Machina is
taking to help the world move from research to production.</p>
<p>One successful rollout proves that a policy can work. Production asks a harder
question. Can we make it work again, explain why it worked, and run it 1,000
times without rebuilding the infrastructure?</p>
<p>The software world has useful answers. Put the work in a directed acyclic graph
(DAG). Declare every input and output. Make execution reproducible. Test the
contract before spending scarce hardware. Never pay twice for identical work.</p>
<p><code>rules_omniverse</code> brings those habits to robotics, the physical world, and the
broader NVIDIA Omniverse ecosystem.</p>
<p>Forge makes this model especially powerful at remote GPU scale, but it is
not required. The rules use Bazel&#39;s execution model. Teams can start locally,
use another compatible remote execution service, or introduce Forge as
their scheduling and caching needs grow.</p>
<p>In our work with leading autonomy teams, we see the same transition again and
again. Research proves that a policy can complete one task in one simulated
world. Production runs that evaluation continuously across hundreds of worlds.
It must preserve the exact scene, policy, toolchain, runtime, and hardware that
produced every result.</p>
<p>That is the problem <code>rules_omniverse</code> takes on.</p>
<h2>The physical world needs a build graph</h2>
<p>A DAG is a map of what depends on what. If a source file changes, a good build
system rebuilds its descendants. It does not rebuild every piece of software in
the company. If nothing relevant changed, it reuses the result. If something
fails, the graph identifies the failed action.</p>
<p>Physical AI needs the same discipline. Its graph contains more than source
code. It includes:</p>
<ul>
<li>OpenUSD scenes</li>
<li>Sensor-derived assets</li>
<li>Omniverse Kit extensions</li>
<li>Simulation configuration</li>
<li>Policy versions</li>
<li>Container images</li>
<li>SDK runtimes</li>
<li>GPU requirements</li>
<li>Rollout outputs</li>
<li>Validation reports</li>
</ul>
<p>Without an explicit graph, those dependencies hide in shell scripts, mutable
machines, shared directories, and people&#39;s memories. A successful rollout is
hard to reproduce. A scene changes while an old result still looks current.
Moving from a workstation to a GPU cluster becomes an infrastructure project.</p>
<p>With Bazel and <code>rules_omniverse</code>, each stage becomes a declared action. The
graph records what the action consumes, what it produces, which executable runs
it, and what kind of worker may execute it.</p>
<p>That is more than a faster script. It records exactly what happened.</p>
<h2>Scale simulation and policy inference independently</h2>
<p>Putting a simulator and a policy model in one large process is convenient for
rollout number one. It is wasteful by rollout number 1,000. Simulation and
policy inference have different compute profiles, bottlenecks, and scaling
curves.</p>
<p>A simulation worker might use an RTX 6000-class GPU to render observations,
advance physics, and capture task state. A policy replica keeps a model loaded,
evaluates those observations, and returns a useful sequence of actions. One
request can return the next action chunk. The simulator does not need a new
inference request for every step.</p>
<p>The system can use two specialized worker pools:</p>
<ul>
<li><strong>Simulation workers</strong> own scene state, rendering, physics, and observation
capture.</li>
<li><strong>Policy workers</strong> own model memory and inference throughput.</li>
</ul>
<p>One policy replica can serve many simulators. Hundreds of simulators can share
a smaller policy pool when latency and throughput allow it. Spare policy
capacity is a reason to add simulators. A growing inference queue is a reason
to add policy replicas.</p>
<p>These are separate knobs because they control separate kinds of work.</p>
<p><code>rules_omniverse</code> does not prescribe an autoscaler or a long-running rollout
control plane. It provides the lower-level action and artifact contracts that
make such a system dependable. Those contracts cover declared simulation
inputs, explicit runtime identity, GPU placement, container boundaries, and
durable outputs. The orchestrator can change without changing what a valid
simulation action means.</p>
<p>Moving from one rollout to 1,000 should be a capacity decision, not an
infrastructure rewrite.</p>
<h2>What is new in 0.3.0</h2>
<p>Version 0.3.0 expands <code>rules_omniverse</code> from Kit packaging and metadata into a
broader execution layer for physical AI:</p>
<ul>
<li><code>omni_gpu_action</code> declares a host GPU workload with explicit inputs, outputs,
tools, arguments, GPU count, GPU model, and execution properties.</li>
<li><code>omni_container_gpu_action</code> does the same for a caller-selected OCI image. It
mounts only declared artifacts and keeps runtime selection in the architect&#39;s
control.</li>
<li><code>omni_gpu_platform</code> describes GPU capabilities and scheduler properties
without hard-coding one GPU generation.</li>
<li>OpenUSD rules cover validation, profiling, conversion, and optimization
through explicit adapters. Typed metadata connects each stage to the next.</li>
<li>Worker-native scripts and configurable packaging tools make the same targets
practical across local and remote execution environments.</li>
<li>Community trusted builders produce provenance attestations for the release
archive and Bazel Central Registry metadata.</li>
</ul>
<p>The release also separates two questions that teams often mix together.</p>
<ol>
<li><strong>Is the rule correct?</strong> Hermetic fixtures test platform constraints,
arguments, inputs, outputs, providers, container behavior, and Bzlmod
consumption. They do not reserve a GPU or require a proprietary SDK.</li>
<li><strong>Does the real hardware and SDK stack work?</strong> A separate Forge
reference bench covers H200 worker matching, NVIDIA runtime initialization,
remote output retrieval, and action cache replay.</li>
</ol>
<p>An RTX 6000, H200, A100, L40S, or another suitable NVIDIA GPU remains a
deployment choice. It is not a ruleset assumption.</p>
<p>Reproducibility starts with the build graph. It should extend to the way the
rules themselves are released. Version 0.3.0 does both.</p>
<h2>A continuously aligned factory</h2>
<p>This work takes Trace Machina beyond two areas where our infrastructure is
already useful: transportation robotics and agents that generate large volumes
of code. Both create enormous graphs of expensive, parallel work. Factories add
a new version of the same systems problem. The graph must stay connected to a
changing physical environment.</p>
<p>In Europe, our recent work with <code>rules_omniverse</code> and Forge includes
simulated factories updated through continuous neural reconstruction. New
observations of a facility become a new version of its digital state. The graph
then has a direct job. It marks affected reconstruction, OpenUSD processing,
validation, packaging, and simulation work as stale. Forge dispatches
those actions to compatible workers. Unaffected content and completed actions
remain reusable.</p>
<p>This is more than rebuilding a digital twin on a schedule. The simulation stays
aligned with evidence from the physical site. Every update carries a traceable
chain of inputs and outputs. A team can ask which observations changed a scene,
which reconstruction produced an asset, which runtime validated it, and which
rollouts consumed it.</p>
<p>The pattern reaches far beyond one factory. Warehouses, industrial inspection,
manufacturing cells, autonomous fleets, synthetic data pipelines, and
hardware-in-the-loop systems all need a controlled way to turn physical change
into new computation.</p>
<h2>Why Forge is the reference backend</h2>
<p>Forge is optional by design. <code>rules_omniverse</code> uses standard Bazel
concepts, so teams get declared DAGs, reproducible actions, OpenUSD validation,
packaging, and portable tests before introducing remote execution.</p>
<p>Forge becomes valuable when the graph must run across specialized
infrastructure. Its Remote Execution API scheduler can match actions to worker
properties such as GPU model, GPU count, container capability, and a truthful
runtime fingerprint. Its content-addressable store and action cache share
immutable inputs and reuse completed work. Its worker configuration gives
operators control over SDK environments, timeouts, isolation, and the
properties that separate incompatible runtimes.</p>
<p>In a mixed simulator and policy system, graphics-heavy simulation actions do
not need to compete with model-serving workloads for the same machines. In a
continuously reconstructed factory, new scene work can start as observations
arrive while unchanged dependencies stay reusable.</p>
<p>The same Bazel target can move from a local proof to remote GPU execution
without replacing its dependency model.</p>
<h2>From research result to production system</h2>
<p>Research velocity and production discipline are often treated as opposing
forces. They should reinforce each other. A researcher should be able to add a
scene, policy, or evaluation without filing an infrastructure request. A
production engineer should be able to reproduce that result without
reconstructing the researcher&#39;s workstation.</p>
<p>In practical terms, <code>rules_omniverse</code> lets a team:</p>
<ul>
<li>Define simulation, asset, packaging, and GPU work as reviewable targets.</li>
<li>Catch contract failures without consuming scarce hardware.</li>
<li>Route real actions to workers that truthfully advertise required
capabilities.</li>
<li>Reuse identical work and invalidate results when meaningful inputs change.</li>
<li>Scale simulation and policy inference around their independent bottlenecks.</li>
<li>Preserve the same graph as a workflow grows from one rollout to 1,000.</li>
</ul>
<p><code>rules_omniverse</code> brings proven lessons from software into robotics and the
industries that build the physical world. DAGs make dependencies explicit.
Reproducibility turns a promising result into evidence. Bazel gives the work a
portable execution contract. Forge adds specialized scheduling,
content-addressable storage, and shared caching when teams need them.</p>
<p>Our work with autonomy teams has made the wider need clear. Transportation,
code-generating agents, factories, and other physical systems all need a
reliable path from a changing idea or observation to tested production work.</p>
<p>One rollout can be an experiment. One thousand rollouts are a system. The graph
should survive that change.</p>
<p>Explore <a href="https://github.com/TraceMachina/rules_omniverse/tree/v0.3.0"><code>rules_omniverse</code> 0.3.0 on
GitHub</a> or add it to
your project through the <a href="https://registry.bazel.build/modules/rules_omniverse">Bazel Central Registry</a>.</p>
7:X
c:X
c:C
0:{"buildId":"KOFMzPd7o5DOrtfpDCIcw","data":[{"rsc":["$","$1","c",{"children":[[["$","section",null,{"className":"relative overflow-hidden","children":[["$","div",null,{"className":"pointer-events-none absolute inset-x-0 top-0 -z-10 h-[400px] bg-[radial-gradient(ellipse_900px_400px_at_50%_-10%,rgb(var(--nl-color-brand)/0.10),transparent_70%)]"}],["$","section",null,{"className":"relative px-6 py-20 pt-24 pb-6 md:pt-32 md:pb-8","children":["$","div",null,{"className":"mx-auto w-full max-w-[1200px]","children":["$","div",null,{"className":"mx-auto max-w-[760px]","children":[["$","a",null,{"href":"/resources/blog","className":"font-mono text-sm text-brand transition-colors hover:text-foreground","children":"← All posts"}],["$","div",null,{"className":"mt-8 flex flex-wrap items-center gap-2","children":[["$","span","announcements",{"className":"inline-flex items-center gap-1.5 rounded-full border px-2.5 py-1 font-mono text-[11px] uppercase tracking-[0.12em] leading-none border-border-strong bg-transparent text-foreground","children":"announcements"}],["$","span","robotics",{"className":"inline-flex items-center gap-1.5 rounded-full border px-2.5 py-1 font-mono text-[11px] uppercase tracking-[0.12em] leading-none border-border-strong bg-transparent text-foreground","children":"robotics"}],["$","span","simulation",{"className":"inline-flex items-center gap-1.5 rounded-full border px-2.5 py-1 font-mono text-[11px] uppercase tracking-[0.12em] leading-none border-border-strong bg-transparent text-foreground","children":"simulation"}],["$","span","bazel",{"className":"inline-flex items-center gap-1.5 rounded-full border px-2.5 py-1 font-mono text-[11px] uppercase tracking-[0.12em] leading-none border-border-strong bg-transparent text-foreground","children":"bazel"}]]}],["$","h1",null,{"className":"mt-5 text-balance text-[32px] font-semibold leading-[1.12] tracking-[-0.03em] md:text-[42px]","children":"From One Robot to 1,000 with rules_omniverse"}],["$","p",null,{"className":"mt-4 font-mono text-xs tracking-wide text-muted","children":["August 27, 2026"," · 8 minutes"]}]]}]}]}]]}],["$","section",null,{"className":"relative px-6 py-20 pt-2 pb-28 md:pt-0","children":["$","div",null,{"className":"mx-auto w-full max-w-[1200px]","children":["$","div",null,{"className":"mx-auto max-w-[760px]","children":[["$","div",null,{"className":"$2","dangerouslySetInnerHTML":{"__html":"$3"}}],"$L4"]}]}]}]],null,"$L5"]}],"isPartial":"$@6","staleTime":"$7","varyParams":null},{"rsc":"$L8","isPartial":"$@9","staleTime":"$7","varyParams":null},{"rsc":"$La","isPartial":"$@b","staleTime":"$7","varyParams":"$c"},{"rsc":"$Ld","isPartial":"$@e","staleTime":"$7","varyParams":"$c"},{"rsc":"$Lf","isPartial":"$@10","staleTime":"$7","varyParams":"$c"}],"isUpgradeableISRFallback":false,"a":"$@11","rootVaryParams":null,"needsRuntimeRequest":"$@12"}
13:I[97367,["/_next/static/chunks/0h2qsuyze9ds1.js"],"OutletBoundary"]
14:"$Sreact.suspense"
16:I[97367,["/_next/static/chunks/0h2qsuyze9ds1.js"],"ViewportBoundary"]
17:I[97367,["/_next/static/chunks/0h2qsuyze9ds1.js"],"MetadataBoundary"]
18:I[27201,["/_next/static/chunks/0h2qsuyze9ds1.js"],"IconMark"]
19:I[39756,["/_next/static/chunks/0h2qsuyze9ds1.js"],"default"]
1a:I[37457,["/_next/static/chunks/0h2qsuyze9ds1.js"],"default"]
4:["$","div",null,{"className":"mt-16 border-t border-border pt-8","children":[["$","p",null,{"className":"font-mono uppercase tracking-[0.18em] text-muted text-[10px]","children":"Forge Blog"}],["$","p",null,{"className":"mt-3 text-sm text-muted-foreground","children":["$","a",null,{"href":"/resources/blog","className":"text-brand transition-colors hover:text-foreground","children":"← Back to all posts"}]}]]}]
5:["$","$L13",null,{"children":["$","$14",null,{"name":"Next.MetadataOutlet","children":"$@15"}]}]
8:["$","$1","h",{"children":[null,["$","$L16",null,{"children":[["$","meta","0",{"charSet":"utf-8"}],["$","meta","1",{"name":"viewport","content":"width=device-width, initial-scale=1"}]]}],["$","div",null,{"hidden":true,"children":["$","$L17",null,{"children":["$","$14",null,{"name":"Next.Metadata","children":[["$","title","0",{"children":"From One Robot to 1,000 with rules_omniverse — Forge"}],["$","meta","1",{"name":"description","content":"Today we are releasing our first official Bazel ruleset for physical AI. It is built to carry robotics work from research to production."}],["$","meta","2",{"property":"og:title","content":"From One Robot to 1,000 with rules_omniverse"}],["$","meta","3",{"property":"og:description","content":"Today we are releasing our first official Bazel ruleset for physical AI. It is built to carry robotics work from research to production."}],["$","meta","4",{"property":"og:type","content":"article"}],["$","meta","5",{"name":"twitter:card","content":"summary"}],["$","meta","6",{"name":"twitter:title","content":"From One Robot to 1,000 with rules_omniverse"}],["$","meta","7",{"name":"twitter:description","content":"Today we are releasing our first official Bazel ruleset for physical AI. It is built to carry robotics work from research to production."}],["$","link","8",{"rel":"icon","href":"/icon.svg?icon.1u05eo7bsa_k9.svg","sizes":"any","type":"image/svg+xml"}],["$","$L18","9",{}]]}]}]}],["$","meta",null,{"name":"next-size-adjust","content":""}]]}]
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
