---
title: "IPFS Day Two"
date: 2020-12-02T00:00:00-00:00
draft: false
---
See the [previous blog post](/posts/2020/12/01/ipfs-hosting) about how I put this site on IPFS
(InterPlanetary File System).

## Latency of IPFS
Accessing `xrop.me` with Cloudflare had relatively high latency, with page
loads lasting a few seconds.
Instead of using IPNS (InterPlanetary Name System) names, I tested accessing the
site directly through its CID (content identifier).
The difference was quite significant.
Loading times went from multiple seconds to a maximum of hundreds of
milliseconds.

This is not suprising, as the [IPFS documentation](https://web.archive.org/web/20201117234738/https://docs.ipfs.io/concepts/ipns/) mentions this exact scenario:
> "You can also use DNSLink, which is currently much faster than IPNS and also
> uses human-readable names."

I had previously been attempting to use IPNS in conjunction with DNSLink.
The resulting setup is not that different as compared to the prior one.
In the Cloudflare DNS settings, I set the TXT DNSLink record to point to an 
IPFS content identifier, as can be seen here. 

<img src="/posts/2020/12/02/ipfs-day-two/dns.png" style="max-width: 95%;">

## Sustainability of IPFS on a Home Network
As I mentioned in the previous blog post, I tried to run an IPFS node on a
Raspberry Pi 4.
However, the daemon consumed two gigabytes of bandwidth over the span of fifteen
hours, with an equal ratio of ingress to egress.
Assuming that this rate of consumption stays constant, this would result in
around 96 gigabytes of bandwidth being consumed in a month.

This isn't quite as bad as when I tried to download close to 300 gigabytes of
the full Bitcoin blockchain over the span of a few days (The ISP didn't quite
like that).
Though, for now this resource consumption is not sustainable on my home
broadband link.
It seems that settings for resource constraints that can be built into the daemon
[have been discussed](https://github.com/ipfs/go-ipfs/issues/1482) over the past
few years; however, such functionality is not present in the official IPFS
daemon written in Go as of the writing of this article.

For now, I have the site pinned to [Pinata](https://pinata.cloud).
However, I will probably look into other methods of contraining bandwidth.
