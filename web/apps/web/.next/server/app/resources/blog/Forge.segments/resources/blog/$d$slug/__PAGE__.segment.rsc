1:"$Sreact.fragment"
2:T982,text-[1.0625rem] leading-[1.75] text-muted-foreground [&_h1]:mb-6 [&_h1]:text-4xl [&_h1]:font-semibold [&_h1]:leading-[1.15] [&_h1]:tracking-[-0.025em] [&_h1]:text-foreground [&_h2]:mt-12 [&_h2]:mb-4 [&_h2]:text-[1.6rem] [&_h2]:font-semibold [&_h2]:leading-[1.25] [&_h2]:tracking-[-0.02em] [&_h2]:text-foreground [&_h3]:mt-9 [&_h3]:mb-3 [&_h3]:text-xl [&_h3]:font-semibold [&_h3]:leading-[1.3] [&_h3]:text-foreground [&_h4]:mt-8 [&_h4]:mb-2 [&_h4]:text-lg [&_h4]:font-semibold [&_h4]:text-foreground [&_p]:my-[1.15em] [&_strong]:font-semibold [&_strong]:text-foreground [&_a]:font-medium [&_a]:text-brand [&_a]:underline [&_a]:underline-offset-4 hover:[&_a]:text-brand-strong [&_ul]:my-[1.15em] [&_ul]:list-disc [&_ul]:pl-6 [&_ol]:my-[1.15em] [&_ol]:list-decimal [&_ol]:pl-6 [&_li]:my-1.5 [&_li]:pl-1 [&_blockquote]:my-8 [&_blockquote]:border-l-2 [&_blockquote]:border-brand/50 [&_blockquote]:pl-6 [&_blockquote]:text-foreground [&_blockquote_p]:my-0 [&_blockquote_p:first-of-type]:text-[1.5rem] [&_blockquote_p:first-of-type]:leading-[1.3] [&_blockquote_p:first-of-type]:font-medium [&_blockquote_p:first-of-type]:tracking-[-0.02em] md:[&_blockquote_p:first-of-type]:text-[1.75rem] [&_blockquote_p:not(:first-of-type)]:mt-3 [&_blockquote_p:not(:first-of-type)]:text-[0.95rem] [&_blockquote_p:not(:first-of-type)]:font-normal [&_blockquote_p:not(:first-of-type)]:leading-normal [&_blockquote_p:not(:first-of-type)]:tracking-normal [&_blockquote_p:not(:first-of-type)]:text-muted-foreground [&_blockquote_p:not(:first-of-type)]:not-italic [&_table]:my-6 [&_table]:w-full [&_table]:border-collapse [&_table]:text-[0.95em] [&_th]:border-b [&_th]:border-border [&_th]:py-2.5 [&_th]:pr-4 [&_th]:text-left [&_th]:font-semibold [&_th]:text-foreground [&_td]:border-b [&_td]:border-border/60 [&_td]:py-2.5 [&_td]:pr-4 [&_td]:align-top [&_tr:last-child_td]:border-b-0 [&_img]:my-8 [&_img]:rounded-xl [&_hr]:my-10 [&_hr]:border-border/60 [&_code]:rounded [&_code]:bg-foreground/5 [&_code]:px-1.5 [&_code]:py-0.5 [&_code]:font-mono [&_code]:text-[0.875em] [&_pre]:my-6 [&_pre]:overflow-x-auto [&_pre]:rounded-lg [&_pre]:border [&_pre]:border-border [&_pre]:bg-foreground/[0.03] [&_pre]:p-4 [&_pre]:font-mono [&_pre]:text-sm [&_pre]:leading-relaxed [&_pre_code]:bg-transparent [&_pre_code]:p-0 [&_pre_code]:text-inherit blog-prose max-w-none [&_img:not(.glance-logo)]:my-6 [&_img:not(.glance-logo)]:max-w-full [&_img:not(.glance-logo)]:rounded-xl3:T62a,<p>Today, we&#39;re excited to release Forge–a Rust implementation of Bazel&#39;s
Remote Build Execution protocol (RBE) and Content Addressable Storage (CAS)
designed to run your code and get out of the way. Forge seamlessly
integrates with Bazel, Siso, Goma, and Buck2. It comes at no cost and
works on every major operating system.</p>
<p>Offering a vendor neutral solution out the gate was important to us and we
will soon offer more options. Part of vendor neutrality began with
supporting four different build systems that implement the RBE protocol.
Given our focus on mission-critical systems with native code,
reproducibility and hermiticity have been our guiding lights.</p>
<p>Based on feedback from our earliest users, we made a few design choices
around the runtime, I/O, and software supply chain. We don&#39;t have any
garbage collection, supporting more deterministic and predictable
execution. In addition, the tunable and highly performant asynchronicity
afforded by Rust has allowed us to achieve concurrency and memory safety that were previously impracticable in most industries prior to its
creation. Ultimately, we  strive for scale, modern SBOM transparency, and
verifiability. The software supply chain is the biggest threat to computer
security in 2023. For mission critical products, the risks are much
greater. Critical systems can&#39;t rely on closed source.</p>
<p>Your contributions, questions, and community support are encouraged. Join
our Slack to learn more.</p>
<p>The free &amp; open source simulation infrastructure platform, in Rust</p>
7:X
c:X
c:C
0:{"buildId":"KOFMzPd7o5DOrtfpDCIcw","data":[{"rsc":["$","$1","c",{"children":[[["$","section",null,{"className":"relative overflow-hidden","children":[["$","div",null,{"className":"pointer-events-none absolute inset-x-0 top-0 -z-10 h-[400px] bg-[radial-gradient(ellipse_900px_400px_at_50%_-10%,rgb(var(--nl-color-brand)/0.10),transparent_70%)]"}],["$","section",null,{"className":"relative px-6 py-20 pt-24 pb-6 md:pt-32 md:pb-8","children":["$","div",null,{"className":"mx-auto w-full max-w-[1200px]","children":["$","div",null,{"className":"mx-auto max-w-[760px]","children":[["$","a",null,{"href":"/resources/blog","className":"font-mono text-sm text-brand transition-colors hover:text-foreground","children":"← All posts"}],["$","div",null,{"className":"mt-8 flex flex-wrap items-center gap-2","children":[["$","span","news",{"className":"inline-flex items-center gap-1.5 rounded-full border px-2.5 py-1 font-mono text-[11px] uppercase tracking-[0.12em] leading-none border-border-strong bg-transparent text-foreground","children":"news"}],["$","span","announcements",{"className":"inline-flex items-center gap-1.5 rounded-full border px-2.5 py-1 font-mono text-[11px] uppercase tracking-[0.12em] leading-none border-border-strong bg-transparent text-foreground","children":"announcements"}]]}],["$","h1",null,{"className":"mt-5 text-balance text-[32px] font-semibold leading-[1.12] tracking-[-0.03em] md:text-[42px]","children":"Forge - The free & open source simulation infrastructure platform written in Rust"}],["$","p",null,{"className":"mt-4 font-mono text-xs tracking-wide text-muted","children":["September 17, 2024"," · 30 seconds"]}]]}]}]}]]}],["$","section",null,{"className":"relative px-6 py-20 pt-2 pb-28 md:pt-0","children":["$","div",null,{"className":"mx-auto w-full max-w-[1200px]","children":["$","div",null,{"className":"mx-auto max-w-[760px]","children":[["$","div",null,{"className":"$2","dangerouslySetInnerHTML":{"__html":"$3"}}],"$L4"]}]}]}]],null,"$L5"]}],"isPartial":"$@6","staleTime":"$7","varyParams":null},{"rsc":"$L8","isPartial":"$@9","staleTime":"$7","varyParams":null},{"rsc":"$La","isPartial":"$@b","staleTime":"$7","varyParams":"$c"},{"rsc":"$Ld","isPartial":"$@e","staleTime":"$7","varyParams":"$c"},{"rsc":"$Lf","isPartial":"$@10","staleTime":"$7","varyParams":"$c"}],"isUpgradeableISRFallback":false,"a":"$@11","rootVaryParams":null,"needsRuntimeRequest":"$@12"}
13:I[97367,["/_next/static/chunks/0h2qsuyze9ds1.js"],"OutletBoundary"]
14:"$Sreact.suspense"
16:I[97367,["/_next/static/chunks/0h2qsuyze9ds1.js"],"ViewportBoundary"]
17:I[97367,["/_next/static/chunks/0h2qsuyze9ds1.js"],"MetadataBoundary"]
18:I[27201,["/_next/static/chunks/0h2qsuyze9ds1.js"],"IconMark"]
19:I[39756,["/_next/static/chunks/0h2qsuyze9ds1.js"],"default"]
1a:I[37457,["/_next/static/chunks/0h2qsuyze9ds1.js"],"default"]
4:["$","div",null,{"className":"mt-16 border-t border-border pt-8","children":[["$","p",null,{"className":"font-mono uppercase tracking-[0.18em] text-muted text-[10px]","children":"Forge Blog"}],["$","p",null,{"className":"mt-3 text-sm text-muted-foreground","children":["$","a",null,{"href":"/resources/blog","className":"text-brand transition-colors hover:text-foreground","children":"← Back to all posts"}]}]]}]
5:["$","$L13",null,{"children":["$","$14",null,{"name":"Next.MetadataOutlet","children":"$@15"}]}]
8:["$","$1","h",{"children":[null,["$","$L16",null,{"children":[["$","meta","0",{"charSet":"utf-8"}],["$","meta","1",{"name":"viewport","content":"width=device-width, initial-scale=1"}]]}],["$","div",null,{"hidden":true,"children":["$","$L17",null,{"children":["$","$14",null,{"name":"Next.Metadata","children":[["$","title","0",{"children":"Forge - The free & open source simulation infrastructure platform written in Rust — Forge"}],["$","meta","1",{"name":"description","content":"Today, we're excited to release Forge–a Rust implementation of Bazel's Remote Build Execution protocol (RBE) and Content Addressable Storage (CAS) designed to run your code and get out of the way.…"}],["$","meta","2",{"property":"og:title","content":"Forge - The free & open source simulation infrastructure platform written in Rust"}],["$","meta","3",{"property":"og:description","content":"Today, we're excited to release Forge–a Rust implementation of Bazel's Remote Build Execution protocol (RBE) and Content Addressable Storage (CAS) designed to run your code and get out of the way.…"}],["$","meta","4",{"property":"og:image","content":"https://forge-cdn.s3.us-east-1.amazonaws.com/forge_open_source.webp"}],["$","meta","5",{"property":"og:type","content":"article"}],["$","meta","6",{"name":"twitter:card","content":"summary_large_image"}],["$","meta","7",{"name":"twitter:title","content":"Forge - The free & open source simulation infrastructure platform written in Rust"}],["$","meta","8",{"name":"twitter:description","content":"Today, we're excited to release Forge–a Rust implementation of Bazel's Remote Build Execution protocol (RBE) and Content Addressable Storage (CAS) designed to run your code and get out of the way.…"}],["$","meta","9",{"name":"twitter:image","content":"https://forge-cdn.s3.us-east-1.amazonaws.com/forge_open_source.webp"}],["$","link","10",{"rel":"icon","href":"/icon.svg?icon.1u05eo7bsa_k9.svg","sizes":"any","type":"image/svg+xml"}],["$","$L18","11",{}]]}]}]}],["$","meta",null,{"name":"next-size-adjust","content":""}]]}]
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
