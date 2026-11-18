1:"$Sreact.fragment"
2:T982,text-[1.0625rem] leading-[1.75] text-muted-foreground [&_h1]:mb-6 [&_h1]:text-4xl [&_h1]:font-semibold [&_h1]:leading-[1.15] [&_h1]:tracking-[-0.025em] [&_h1]:text-foreground [&_h2]:mt-12 [&_h2]:mb-4 [&_h2]:text-[1.6rem] [&_h2]:font-semibold [&_h2]:leading-[1.25] [&_h2]:tracking-[-0.02em] [&_h2]:text-foreground [&_h3]:mt-9 [&_h3]:mb-3 [&_h3]:text-xl [&_h3]:font-semibold [&_h3]:leading-[1.3] [&_h3]:text-foreground [&_h4]:mt-8 [&_h4]:mb-2 [&_h4]:text-lg [&_h4]:font-semibold [&_h4]:text-foreground [&_p]:my-[1.15em] [&_strong]:font-semibold [&_strong]:text-foreground [&_a]:font-medium [&_a]:text-brand [&_a]:underline [&_a]:underline-offset-4 hover:[&_a]:text-brand-strong [&_ul]:my-[1.15em] [&_ul]:list-disc [&_ul]:pl-6 [&_ol]:my-[1.15em] [&_ol]:list-decimal [&_ol]:pl-6 [&_li]:my-1.5 [&_li]:pl-1 [&_blockquote]:my-8 [&_blockquote]:border-l-2 [&_blockquote]:border-brand/50 [&_blockquote]:pl-6 [&_blockquote]:text-foreground [&_blockquote_p]:my-0 [&_blockquote_p:first-of-type]:text-[1.5rem] [&_blockquote_p:first-of-type]:leading-[1.3] [&_blockquote_p:first-of-type]:font-medium [&_blockquote_p:first-of-type]:tracking-[-0.02em] md:[&_blockquote_p:first-of-type]:text-[1.75rem] [&_blockquote_p:not(:first-of-type)]:mt-3 [&_blockquote_p:not(:first-of-type)]:text-[0.95rem] [&_blockquote_p:not(:first-of-type)]:font-normal [&_blockquote_p:not(:first-of-type)]:leading-normal [&_blockquote_p:not(:first-of-type)]:tracking-normal [&_blockquote_p:not(:first-of-type)]:text-muted-foreground [&_blockquote_p:not(:first-of-type)]:not-italic [&_table]:my-6 [&_table]:w-full [&_table]:border-collapse [&_table]:text-[0.95em] [&_th]:border-b [&_th]:border-border [&_th]:py-2.5 [&_th]:pr-4 [&_th]:text-left [&_th]:font-semibold [&_th]:text-foreground [&_td]:border-b [&_td]:border-border/60 [&_td]:py-2.5 [&_td]:pr-4 [&_td]:align-top [&_tr:last-child_td]:border-b-0 [&_img]:my-8 [&_img]:rounded-xl [&_hr]:my-10 [&_hr]:border-border/60 [&_code]:rounded [&_code]:bg-foreground/5 [&_code]:px-1.5 [&_code]:py-0.5 [&_code]:font-mono [&_code]:text-[0.875em] [&_pre]:my-6 [&_pre]:overflow-x-auto [&_pre]:rounded-lg [&_pre]:border [&_pre]:border-border [&_pre]:bg-foreground/[0.03] [&_pre]:p-4 [&_pre]:font-mono [&_pre]:text-sm [&_pre]:leading-relaxed [&_pre_code]:bg-transparent [&_pre_code]:p-0 [&_pre_code]:text-inherit blog-prose max-w-none [&_img:not(.glance-logo)]:my-6 [&_img:not(.glance-logo)]:max-w-full [&_img:not(.glance-logo)]:rounded-xl3:T18f6,<p>CIQ is an enterprise company that specializes in Linux distribution,
computing infrastructure, and cluster management and provisioning systems.
They have a deep running commitment to supporting open source projects and
creating enterprise-level support for them: They&#39;re the Founding Sponsor of
Rocky Linux, an open source operating system that rebuilds sources directly
from Red Hat Enterprise Linux (RHEL); they support an open source project
called Warewulf that&#39;s a cluster management and provisioning system to help
simplify deployment and management of compute clusters; and they supported
and donated Singularity (later named to Apptainer) to the Linux Foundation
that&#39;s designed to bring containers to high performance computing.</p>
<p>All of CIQ enterprise solutions, which are developed from their support and
contributions to the open source projects, are consolidated into one
repository, known as a monolithic repository (monorepo). A monorepo allows
CIQ to ensure all projects (solutions) are consistent and integrated
effectively, simplify dependency management as updates can be made
uniformly across the codebase, streamline CI/CD pipelines, and facilitate
cross-team collaboration and more. Since thousands of customers rely on
their solutions for mission-critical use cases, it’s imperative for them to
maintain the monorepo to:</p>
<p>ensure consistency across any environment, architectures, libraries,
services, and tools
efficiently update and maintain features with no downtime
rapidly debug issues and patches across the entire codebase
perform comprehensive testing and validation across all projects
improve the scalability as the codebase grows</p>
<p>CIQ needed a remote execution service to help dynamically scale their
compute resources, optimize build times, and handle increasing demands.</p>
<p>Storage Scalability Challenges
Physical disk resizing
CIQ previously relied on a solution where storage management was based on a
block-level architecture. Data was stored and accessed in fixed-size blocks
that’s directly tied to physical storage devices. The only way to increase
storage capacity is to physically resize the hard drives. As the data volume
increased, they had to consistently resize the disk. This impracticality was
time consuming and not scalable. When their previous solution couldn&#39;t handle
the demand and scale for their needs, CIQ turned to Forge for a more
robust and maintainable alternative.</p>
<p>Cloud-based storage
The other challenge CIQ faced was integrating with cloud-based distributed
storage systems like AWS S3 and Google Cloud Storage (GCS). This obstacle
primarily stemmed from legacy storage architecture where they heavily relied
on physical disk-based block storage. The block storage architecture couldn&#39;t
seamlessly interface with cloud-based distributed storage systems that are
designed to be elastic and offer on-demand scaling. This incompatibility made
it difficult for CIQ to take advantage of the cloud’s ability to adjust
storage capacity based on demand. They had high resource utilization waste
and couldn’t fully capitalize on cost performance benefits that cloud storage
provides.</p>
<p>Implementing and maintaining Forge
One of the standout features of Forge for the CIQ team was its intuitive
codebase housed in a single repository. Forge’s logical separation of
components enabled CIQ’s engineers to efficiently pinpoint the source of any
errors, and each component&#39;s responsibilities were well-defined, allowing for
swift problem resolution. The simplicity of Forge’s architecture meant
that most issues were addressed during the setup phase, minimizing the risk
of future errors.</p>
<p>For CIQ, Forge is also incredibly low-touch when it comes to
maintenance. It provided a significant improvement in managing physical disk
storage compared to BuildBarn. Changing the physical disk sizes required
adjusting the Persistent Volume Claim (PVC) on Kubernetes (k8s) to reflect
the desired storage capacity and then update the storage configuration. This
streamlined CIQ’s process to quickly scale the physical disks with minimal
effort and adjust eviction policies.</p>
<p>Furthermore, Forge integrates seamlessly with cloud-based storage
systems, like S3. This enables CIQ to scale their infrastructure up or down
with flexibility and elasticity as their needs evolve. They now can
efficiently run multiple Content Addressable Storage (CAS) nodes. This
flexibility and reliability allowed CIQ to focus on more critical aspects of
their operations, knowing that their RBE system was stable and dependable.
For them, all of Forge’s setup was almost a “fire and forget” operation
for the CIQ team.</p>
<p>The results
Operational savings - CIQ is able to avoid unnecessary provisioning of
resources and can scale their node pool with confidence. In addition, because
they no longer worry about the complexity of client-oriented scheduling,
higher Bazel jobs that would once overwhelm the system and cause timeouts and
other issues are handled with ease.
Efficient resource management - Forge has allowed CIQ to maintain a
consistent spot node pool of workers since deployment. Even with increased
activity, the system has remained stable, eliminating the need for constant
scaling. Additionally, Forge’s ability to handle all actions remotely
without the need to download CAS objects to GitHub Actions has provided
substantial savings in both time and resources.
Reduced CI and deployment times - Since implementing Forge, CIQ has been
able to reduce their CI times drastically, with average PR CI time from 15
minutes to 3 minutes and full service deployment times dropping from an
average of over 1 hour to 15 minutes from code merge.</p>
<p>Conclusion
Because of Forge, CIQ has been able to eliminate significant technical
challenges, see reduced operational costs, and increased efficiency. With
Forge’s intuitive architecture, ease of use, and minimal maintenance
requirements, CIQ has been able to scale with confidence and its engineers
empowered to focus on what they do best—building innovative solutions without
the distractions of an unreliable RBE system.</p>
<p>To learn more about Forge, read our documentation, check out our GitHub
Repository, or contact our team directly at <a href="mailto:hello@forge.com">hello@forge.com</a>.</p>
7:X
c:X
c:C
0:{"buildId":"KOFMzPd7o5DOrtfpDCIcw","data":[{"rsc":["$","$1","c",{"children":[[["$","section",null,{"className":"relative overflow-hidden","children":[["$","div",null,{"className":"pointer-events-none absolute inset-x-0 top-0 -z-10 h-[400px] bg-[radial-gradient(ellipse_900px_400px_at_50%_-10%,rgb(var(--nl-color-brand)/0.10),transparent_70%)]"}],["$","section",null,{"className":"relative px-6 py-20 pt-24 pb-6 md:pt-32 md:pb-8","children":["$","div",null,{"className":"mx-auto w-full max-w-[1200px]","children":["$","div",null,{"className":"mx-auto max-w-[760px]","children":[["$","a",null,{"href":"/resources/blog","className":"font-mono text-sm text-brand transition-colors hover:text-foreground","children":"← All posts"}],["$","div",null,{"className":"mt-8 flex flex-wrap items-center gap-2","children":[["$","span","news",{"className":"inline-flex items-center gap-1.5 rounded-full border px-2.5 py-1 font-mono text-[11px] uppercase tracking-[0.12em] leading-none border-border-strong bg-transparent text-foreground","children":"news"}],["$","span","case-studies",{"className":"inline-flex items-center gap-1.5 rounded-full border px-2.5 py-1 font-mono text-[11px] uppercase tracking-[0.12em] leading-none border-border-strong bg-transparent text-foreground","children":"case-studies"}]]}],["$","h1",null,{"className":"mt-5 text-balance text-[32px] font-semibold leading-[1.12] tracking-[-0.03em] md:text-[42px]","children":"Case Study: CIQ"}],["$","p",null,{"className":"mt-4 font-mono text-xs tracking-wide text-muted","children":["August 13, 2024"," · 2 minutes"]}]]}]}]}]]}],["$","section",null,{"className":"relative px-6 py-20 pt-2 pb-28 md:pt-0","children":["$","div",null,{"className":"mx-auto w-full max-w-[1200px]","children":["$","div",null,{"className":"mx-auto max-w-[760px]","children":[["$","div",null,{"className":"$2","dangerouslySetInnerHTML":{"__html":"$3"}}],"$L4"]}]}]}]],null,"$L5"]}],"isPartial":"$@6","staleTime":"$7","varyParams":null},{"rsc":"$L8","isPartial":"$@9","staleTime":"$7","varyParams":null},{"rsc":"$La","isPartial":"$@b","staleTime":"$7","varyParams":"$c"},{"rsc":"$Ld","isPartial":"$@e","staleTime":"$7","varyParams":"$c"},{"rsc":"$Lf","isPartial":"$@10","staleTime":"$7","varyParams":"$c"}],"isUpgradeableISRFallback":false,"a":"$@11","rootVaryParams":null,"needsRuntimeRequest":"$@12"}
13:I[97367,["/_next/static/chunks/0h2qsuyze9ds1.js"],"OutletBoundary"]
14:"$Sreact.suspense"
16:I[97367,["/_next/static/chunks/0h2qsuyze9ds1.js"],"ViewportBoundary"]
17:I[97367,["/_next/static/chunks/0h2qsuyze9ds1.js"],"MetadataBoundary"]
18:I[27201,["/_next/static/chunks/0h2qsuyze9ds1.js"],"IconMark"]
19:I[39756,["/_next/static/chunks/0h2qsuyze9ds1.js"],"default"]
1a:I[37457,["/_next/static/chunks/0h2qsuyze9ds1.js"],"default"]
4:["$","div",null,{"className":"mt-16 border-t border-border pt-8","children":[["$","p",null,{"className":"font-mono uppercase tracking-[0.18em] text-muted text-[10px]","children":"Forge Blog"}],["$","p",null,{"className":"mt-3 text-sm text-muted-foreground","children":["$","a",null,{"href":"/resources/blog","className":"text-brand transition-colors hover:text-foreground","children":"← Back to all posts"}]}]]}]
5:["$","$L13",null,{"children":["$","$14",null,{"name":"Next.MetadataOutlet","children":"$@15"}]}]
8:["$","$1","h",{"children":[null,["$","$L16",null,{"children":[["$","meta","0",{"charSet":"utf-8"}],["$","meta","1",{"name":"viewport","content":"width=device-width, initial-scale=1"}]]}],["$","div",null,{"hidden":true,"children":["$","$L17",null,{"children":["$","$14",null,{"name":"Next.Metadata","children":[["$","title","0",{"children":"Case Study: CIQ — Forge"}],["$","meta","1",{"name":"description","content":"CIQ is an enterprise company that specializes in Linux distribution, computing infrastructure, and cluster management and provisioning systems. They have a deep running commitment to supporting ope…"}],["$","meta","2",{"property":"og:title","content":"Case Study: CIQ"}],["$","meta","3",{"property":"og:description","content":"CIQ is an enterprise company that specializes in Linux distribution, computing infrastructure, and cluster management and provisioning systems. They have a deep running commitment to supporting ope…"}],["$","meta","4",{"property":"og:image","content":"https://forge-cdn.s3.us-east-1.amazonaws.com/forge_ciq.webp"}],["$","meta","5",{"property":"og:type","content":"article"}],["$","meta","6",{"name":"twitter:card","content":"summary_large_image"}],["$","meta","7",{"name":"twitter:title","content":"Case Study: CIQ"}],["$","meta","8",{"name":"twitter:description","content":"CIQ is an enterprise company that specializes in Linux distribution, computing infrastructure, and cluster management and provisioning systems. They have a deep running commitment to supporting ope…"}],["$","meta","9",{"name":"twitter:image","content":"https://forge-cdn.s3.us-east-1.amazonaws.com/forge_ciq.webp"}],["$","link","10",{"rel":"icon","href":"/icon.svg?icon.1u05eo7bsa_k9.svg","sizes":"any","type":"image/svg+xml"}],["$","$L18","11",{}]]}]}]}],["$","meta",null,{"name":"next-size-adjust","content":""}]]}]
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
