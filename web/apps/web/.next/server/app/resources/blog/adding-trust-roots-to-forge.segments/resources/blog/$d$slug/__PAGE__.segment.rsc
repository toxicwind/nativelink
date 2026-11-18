1:"$Sreact.fragment"
2:T982,text-[1.0625rem] leading-[1.75] text-muted-foreground [&_h1]:mb-6 [&_h1]:text-4xl [&_h1]:font-semibold [&_h1]:leading-[1.15] [&_h1]:tracking-[-0.025em] [&_h1]:text-foreground [&_h2]:mt-12 [&_h2]:mb-4 [&_h2]:text-[1.6rem] [&_h2]:font-semibold [&_h2]:leading-[1.25] [&_h2]:tracking-[-0.02em] [&_h2]:text-foreground [&_h3]:mt-9 [&_h3]:mb-3 [&_h3]:text-xl [&_h3]:font-semibold [&_h3]:leading-[1.3] [&_h3]:text-foreground [&_h4]:mt-8 [&_h4]:mb-2 [&_h4]:text-lg [&_h4]:font-semibold [&_h4]:text-foreground [&_p]:my-[1.15em] [&_strong]:font-semibold [&_strong]:text-foreground [&_a]:font-medium [&_a]:text-brand [&_a]:underline [&_a]:underline-offset-4 hover:[&_a]:text-brand-strong [&_ul]:my-[1.15em] [&_ul]:list-disc [&_ul]:pl-6 [&_ol]:my-[1.15em] [&_ol]:list-decimal [&_ol]:pl-6 [&_li]:my-1.5 [&_li]:pl-1 [&_blockquote]:my-8 [&_blockquote]:border-l-2 [&_blockquote]:border-brand/50 [&_blockquote]:pl-6 [&_blockquote]:text-foreground [&_blockquote_p]:my-0 [&_blockquote_p:first-of-type]:text-[1.5rem] [&_blockquote_p:first-of-type]:leading-[1.3] [&_blockquote_p:first-of-type]:font-medium [&_blockquote_p:first-of-type]:tracking-[-0.02em] md:[&_blockquote_p:first-of-type]:text-[1.75rem] [&_blockquote_p:not(:first-of-type)]:mt-3 [&_blockquote_p:not(:first-of-type)]:text-[0.95rem] [&_blockquote_p:not(:first-of-type)]:font-normal [&_blockquote_p:not(:first-of-type)]:leading-normal [&_blockquote_p:not(:first-of-type)]:tracking-normal [&_blockquote_p:not(:first-of-type)]:text-muted-foreground [&_blockquote_p:not(:first-of-type)]:not-italic [&_table]:my-6 [&_table]:w-full [&_table]:border-collapse [&_table]:text-[0.95em] [&_th]:border-b [&_th]:border-border [&_th]:py-2.5 [&_th]:pr-4 [&_th]:text-left [&_th]:font-semibold [&_th]:text-foreground [&_td]:border-b [&_td]:border-border/60 [&_td]:py-2.5 [&_td]:pr-4 [&_td]:align-top [&_tr:last-child_td]:border-b-0 [&_img]:my-8 [&_img]:rounded-xl [&_hr]:my-10 [&_hr]:border-border/60 [&_code]:rounded [&_code]:bg-foreground/5 [&_code]:px-1.5 [&_code]:py-0.5 [&_code]:font-mono [&_code]:text-[0.875em] [&_pre]:my-6 [&_pre]:overflow-x-auto [&_pre]:rounded-lg [&_pre]:border [&_pre]:border-border [&_pre]:bg-foreground/[0.03] [&_pre]:p-4 [&_pre]:font-mono [&_pre]:text-sm [&_pre]:leading-relaxed [&_pre_code]:bg-transparent [&_pre_code]:p-0 [&_pre_code]:text-inherit blog-prose max-w-none [&_img:not(.glance-logo)]:my-6 [&_img:not(.glance-logo)]:max-w-full [&_img:not(.glance-logo)]:rounded-xl3:T162a,<h1>Native Root Certificate Support in Forge</h1>
<p><strong>Open source thrives on community contributions, and today’s story is a perfect example of why.</strong>
External engineer <a href="https://github.com/s6eskand">Sam Eskandar</a> identified a pain point in Forge&#39;s TLS configuration and delivered <a href="https://github.com/toxicwind/forge/pull/1782">a clean solution</a> that eliminates deployment friction for teams using managed certificates.</p>
<h2>Problem: Manual Certificate Management</h2>
<p>Before this change, connecting to gRPC endpoints using TLS required specifying <a href="https://forge.com/docs/reference/forge-config/#clienttlsconfig"><code>ClientTlsConfig</code></a> like this:</p>
<pre><code class="language-json">{
  ca_file: &quot;path/to/ca.pem&quot;,
  cert_file: &quot;path/to/client.pem&quot;,
  key_file: &quot;path/to/client-key.pem&quot;
}
</code></pre>
<p>Teams had to distribute CA certificates, client certificates, and key files across workers - creating friction for cloud deployments and potential security concerns when secrets need to be managed manually.</p>
<h2>Solution: Native Root Certificate Support</h2>
<p>The new implementation adds a <code>use_native_roots</code> option that leverages the system&#39;s native root certificate store, eliminating manual certificate file management for most deployment scenarios.</p>
<p>The core change is:</p>
<pre><code class="language-rust">if config.use_native_roots == Some(true) {
    if config.ca_file.is_some() {
        warn!(&quot;Native root certificates are being used, all certificate files will be ignored&quot;);
    }
    return Ok(Some(
        tonic::transport::ClientTlsConfig::new().with_native_roots(),
    ));
}
</code></pre>
<p>This implementation provides three distinct behaviors:</p>
<ul>
<li><strong>Native roots enabled:</strong> Use system native root certificates, ignore any provided certificate files</li>
<li><strong>Manual certificate path:</strong> Use existing manual certificate configuration</li>
<li><strong>Clear validation:</strong> Warn users when configurations conflict</li>
</ul>
<h2>Configuration Examples</h2>
<p>Here are the main ways to configure TLS in Forge.
For complete configuration options, see the <a href="https://www.forge.com/docs/reference/forge-config">configuration reference</a>.</p>
<h3>Native Root Certificates</h3>
<p>For the majority of modern deployments, you can now enable native roots with one parameter:</p>
<pre><code class="language-json">{
  &quot;tls_config&quot;: {
    &quot;use_native_roots&quot;: true
  }
}
</code></pre>
<p>This configuration automatically trusts certificates signed by any certificate authority in your system’s trust store - perfect for cloud environments with managed certificates.</p>
<h3>Manual Certificate Path</h3>
<p>Since <code>use_native_roots</code> defaults to <code>false</code>, you can still use the previous configuration:</p>
<pre><code class="language-json">{
  &quot;tls_config&quot;: {
    &quot;ca_file&quot;: &quot;/path/to/ca.pem&quot;,
    &quot;cert_file&quot;: &quot;/path/to/client.pem&quot;,
    &quot;key_file&quot;: &quot;/path/to/client-key.pem&quot;
  }
}
</code></pre>
<h3>gRPC Store and Local Worker Configuration</h3>
<p>The <code>tls_config</code> field can be used in gRPC store endpoints:</p>
<pre><code class="language-json">&quot;stores&quot;: [
  {
    &quot;grpc&quot;: {
      &quot;endpoints&quot;: [
        {
          &quot;address&quot;: &quot;grpcs://example.com:443&quot;,
          &quot;tls_config&quot;: {
            &quot;use_native_roots&quot;: true
          }
        }
      ],
      &quot;instance_name&quot;: &quot;main&quot;,
      &quot;store_type&quot;: &quot;cas&quot;
    },
    &quot;name&quot;: &quot;CAS_STORE&quot;
  }
]
</code></pre>
<p>And in worker API endpoints:</p>
<pre><code class="language-json">&quot;workers&quot;: [{
  &quot;local&quot;: {
    &quot;worker_api_endpoint&quot;: {
      &quot;uri&quot;: &quot;grpcs://127.0.0.1:50061&quot;,
      &quot;tls_config&quot;: {
        &quot;use_native_roots&quot;: true
      }
    },
    // ...
  }
}]
</code></pre>
<h2>Community Contributions</h2>
<p>The <a href="https://github.com/toxicwind/forge/pull/1782">PR discussion</a> shows how the review process strengthened the implementation.
The contributor included comprehensive unit tests covering all configuration scenarios.
Reviewers suggested UX improvements like warning users when certificate files are ignored, identified documentation needs, and planned future enhancements.
One reviewer opened a follow-up PR to extend native roots to S3 stores.</p>
<p>This collaborative refinement process caught edge cases, improved error handling, and identified future improvements - resulting in a more robust implementation than any single contributor could have produced alone.</p>
<h2>Looking forward</h2>
<p>With native root certificate support, Forge becomes more accessible to teams across diverse infrastructure environments.
Whether you’re running containerized workloads in Kubernetes, deploying on traditional virtual machines with corporate PKI, or prototyping locally, TLS configuration no longer presents a barrier to adoption.</p>
<p><strong>This is the power of open source in action</strong> - community-driven improvements that make technology more accessible, secure, and flexible for everyone building the future.
We’re grateful for contributions like this that strengthen Forge’s position as the premier open source remote execution platform.</p>
<hr>
<p><em>Interested in contributing? Check out our <a href="https://github.com/toxicwind/forge">GitHub repository</a>.</em></p>
7:X
c:X
c:C
0:{"buildId":"KOFMzPd7o5DOrtfpDCIcw","data":[{"rsc":["$","$1","c",{"children":[[["$","section",null,{"className":"relative overflow-hidden","children":[["$","div",null,{"className":"pointer-events-none absolute inset-x-0 top-0 -z-10 h-[400px] bg-[radial-gradient(ellipse_900px_400px_at_50%_-10%,rgb(var(--nl-color-brand)/0.10),transparent_70%)]"}],["$","section",null,{"className":"relative px-6 py-20 pt-24 pb-6 md:pt-32 md:pb-8","children":["$","div",null,{"className":"mx-auto w-full max-w-[1200px]","children":["$","div",null,{"className":"mx-auto max-w-[760px]","children":[["$","a",null,{"href":"/resources/blog","className":"font-mono text-sm text-brand transition-colors hover:text-foreground","children":"← All posts"}],["$","div",null,{"className":"mt-8 flex flex-wrap items-center gap-2","children":[["$","span","news",{"className":"inline-flex items-center gap-1.5 rounded-full border px-2.5 py-1 font-mono text-[11px] uppercase tracking-[0.12em] leading-none border-border-strong bg-transparent text-foreground","children":"news"}],["$","span","blog-posts",{"className":"inline-flex items-center gap-1.5 rounded-full border px-2.5 py-1 font-mono text-[11px] uppercase tracking-[0.12em] leading-none border-border-strong bg-transparent text-foreground","children":"blog-posts"}]]}],["$","h1",null,{"className":"mt-5 text-balance text-[32px] font-semibold leading-[1.12] tracking-[-0.03em] md:text-[42px]","children":"Trust Root Support in Forge"}],["$","p",null,{"className":"mt-4 font-mono text-xs tracking-wide text-muted","children":["May 15, 2025"," · 5 minutes"]}]]}]}]}]]}],["$","section",null,{"className":"relative px-6 py-20 pt-2 pb-28 md:pt-0","children":["$","div",null,{"className":"mx-auto w-full max-w-[1200px]","children":["$","div",null,{"className":"mx-auto max-w-[760px]","children":[["$","div",null,{"className":"$2","dangerouslySetInnerHTML":{"__html":"$3"}}],"$L4"]}]}]}]],null,"$L5"]}],"isPartial":"$@6","staleTime":"$7","varyParams":null},{"rsc":"$L8","isPartial":"$@9","staleTime":"$7","varyParams":null},{"rsc":"$La","isPartial":"$@b","staleTime":"$7","varyParams":"$c"},{"rsc":"$Ld","isPartial":"$@e","staleTime":"$7","varyParams":"$c"},{"rsc":"$Lf","isPartial":"$@10","staleTime":"$7","varyParams":"$c"}],"isUpgradeableISRFallback":false,"a":"$@11","rootVaryParams":null,"needsRuntimeRequest":"$@12"}
13:I[97367,["/_next/static/chunks/0h2qsuyze9ds1.js"],"OutletBoundary"]
14:"$Sreact.suspense"
16:I[97367,["/_next/static/chunks/0h2qsuyze9ds1.js"],"ViewportBoundary"]
17:I[97367,["/_next/static/chunks/0h2qsuyze9ds1.js"],"MetadataBoundary"]
18:I[27201,["/_next/static/chunks/0h2qsuyze9ds1.js"],"IconMark"]
19:I[39756,["/_next/static/chunks/0h2qsuyze9ds1.js"],"default"]
1a:I[37457,["/_next/static/chunks/0h2qsuyze9ds1.js"],"default"]
4:["$","div",null,{"className":"mt-16 border-t border-border pt-8","children":[["$","p",null,{"className":"font-mono uppercase tracking-[0.18em] text-muted text-[10px]","children":"Forge Blog"}],["$","p",null,{"className":"mt-3 text-sm text-muted-foreground","children":["$","a",null,{"href":"/resources/blog","className":"text-brand transition-colors hover:text-foreground","children":"← Back to all posts"}]}]]}]
5:["$","$L13",null,{"children":["$","$14",null,{"name":"Next.MetadataOutlet","children":"$@15"}]}]
8:["$","$1","h",{"children":[null,["$","$L16",null,{"children":[["$","meta","0",{"charSet":"utf-8"}],["$","meta","1",{"name":"viewport","content":"width=device-width, initial-scale=1"}]]}],["$","div",null,{"hidden":true,"children":["$","$L17",null,{"children":["$","$14",null,{"name":"Next.Metadata","children":[["$","title","0",{"children":"Trust Root Support in Forge — Forge"}],["$","meta","1",{"name":"description","content":"Open source thrives on community contributions, and today’s story is a perfect example of why. External engineer Sam Eskandar identified a pain point in Forge's TLS configuration and delivered a cl…"}],["$","meta","2",{"property":"og:title","content":"Trust Root Support in Forge"}],["$","meta","3",{"property":"og:description","content":"Open source thrives on community contributions, and today’s story is a perfect example of why. External engineer Sam Eskandar identified a pain point in Forge's TLS configuration and delivered a cl…"}],["$","meta","4",{"property":"og:image","content":"https://forge-cdn.s3.us-east-1.amazonaws.com/forge_logo.webp"}],["$","meta","5",{"property":"og:type","content":"article"}],["$","meta","6",{"name":"twitter:card","content":"summary_large_image"}],["$","meta","7",{"name":"twitter:title","content":"Trust Root Support in Forge"}],["$","meta","8",{"name":"twitter:description","content":"Open source thrives on community contributions, and today’s story is a perfect example of why. External engineer Sam Eskandar identified a pain point in Forge's TLS configuration and delivered a cl…"}],["$","meta","9",{"name":"twitter:image","content":"https://forge-cdn.s3.us-east-1.amazonaws.com/forge_logo.webp"}],["$","link","10",{"rel":"icon","href":"/icon.svg?icon.1u05eo7bsa_k9.svg","sizes":"any","type":"image/svg+xml"}],["$","$L18","11",{}]]}]}]}],["$","meta",null,{"name":"next-size-adjust","content":""}]]}]
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
