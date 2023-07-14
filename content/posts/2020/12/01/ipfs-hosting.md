---
title: "IPFS Hosting"
date: 2020-12-01
draft: false
---

## IPFS
Today I read about IPFS (InterPlanetary File System).
It is a decentralized file storage protocol which utilizes a
distributed hash table.
This means that a block of data is referred to by its hash, and these hashes are
distributed to nodes in the network.
Nodes in the network can request such data by broadcasting that hash (known as a
"content identifier").
Any node that has the data (or part of it) can then send the data back.
This partial satisfaction of a data request is similar to BitTorrent, where portions
of data can come from different nodes simultaneously.
This distributed transfer of data can be beneficial in a number of circumstances;
though, benefits and tradeoffs would most likely fall in accordance with the
[CAP theorem](https://en.wikipedia.org/wiki/CAP_theorem).
My first concern with this particular distributed system was scalability; however,
the compromise looks quite reasonable.
Nodes can decide whether they wish to retain blocks of data by "pinning" the
data; in other words, telling the daemon that the data should never be deleted.
Otherwise, data that has been cached by the node is frequently garbage collected.

## IFPS for Static Web Hosting of `xrop.me`
IPFS aligned with my desire for distributed storage of my site.
I decided to transfer this site over to IPFS.
However, there were a few hurdles.

Web browsers by default use DNS and the Internet Protocol for resolving addresses
and finding servers.
Therefore, I needed to use some kind of proxy to forward requests from a
traditional server into the IPFS network.
The IPFS daemon already has this functionality built in, where a HTTP server is
spun up on port 8080 and can send data from IPFS to the web browser.
Furthermore, there are numerous cloud services which provide this functionality.
I went with Cloudflare.
They provide this gateway functionality, and also they allow for SSL certificates
on domains aliased via a CNAME record.

The second large hurdle was mutating the website.
Each content identifier on IPFS points to a unique piece of data.
As a consequence, the content identifier will change everytime I update the
website.
Fortunately, the IPFS protocol provides a "pointer" addressing system of sorts,
where addresses can be pointed to different content identifiers over time.
This is known as IPNS (InterPlanetary Name System).
I pointed `xrop.me` to
`https://cloudflare-ipfs.com/ipns/k2k4r8pqfxsg6svf4g9mc18f65ev0hdxqk44wpif5hihpt7bsv44sw3y`
via a CNAME record.
`https://cloudflare-ipfs.com` is Cloudflare's IPFS gateway, and the path `ipns`
specifies that the request is for an IPNS name, which points to a content
identifier.
As of the writing of this article, the name
`k2k4r8pqfxsg6svf4g9mc18f65ev0hdxqk44wpif5hihpt7bsv44sw3y`
points to the content identifier
`QmP8pko8Ko7eb4YHV8bYV2nGo6vTpXcfr21Sy8ZiJGoaAq`. This content identifier can
then be accessed on Cloudflare's gateway by accessing 
`https://cloudflare-ipfs.com/ipfs/QmP8pko8Ko7eb4YHV8bYV2nGo6vTpXcfr21Sy8ZiJGoaAq`
(The link will probably not work as old versions of the website will be
unpinned).

I also slightly modified the website source code. I originally used CDNs for imports
such as `Bootstrap` and `MathJax`.
However, I downloaded the libraries and uploaded them alongside the website
source code.
This means that anybody else hosting a website on IPFS using the same libraries
will be sharing the same content identifiers as are used on my site.
People accessing my website or other websites don't necessarily need to access my
website (or nodes who have cached it) to retrieve those libraries on IPFS.
Rather, another node could have the same resource pinned.

I currently have this website pinned on an IPFS instance running on a Raspberry
Pi 4 with NixOS.

## Applications for IPFS
I use NixOS, which allows for reproducible builds through functional package
management.
It, too, uses a filesystem of immutable data blocks referred to by hashes. 
It seems only natural that perhaps NixOS could use IPFS for both storing package
source code, and the resulting builds.
And as I found out, [this is already being done.](https://blog.ipfs.io/2020-09-08-nix-ipfs-milestone-1/)

A natural extension of IPFS in the age of blockchain would be to construct a
marketplace around IPFS.
Filecoin is a cryptocurrency built ontop of IPFS which allows nodes with surplus
disk space to rent out storage to other nodes. As of the writing of this
article, the price of storage on Filecoin is fairly good as well, at twice the
price of Amazon S3.

I have also seen further attempts to distribute the hosting of web content
using IPFS and other technologies as well.
One solution that is attractive is using IPFS for static web hosting,
and then using the Ethereum Name Service, which is a marketplace dapp for
registering domain names ending in `.eth`. When combined with browser extensions
which allow for Ethereum Name Service domains to be resolved and for IPFS data
to be retrieved through a local node instead of through a centralized gateway,
it seems that one can achieve a fairly high level of decentralization.
