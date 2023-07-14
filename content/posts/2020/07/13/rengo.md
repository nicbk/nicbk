---
title: "Rengo"
date: 2020-07-13
draft: false
---

[Pont]: https://news.ycombinator.com/item?id=23649369 "Pont"
[web\_sys]: https://crates.io/crates/web_sys "Rust crate web_sys"
[rengo]: https://github.com/nicbk/rengo.git "Rengo GitLab"
[Actix]: https://crates.io/crates/actix "Actix lib"
[yew]: https://crates.io/crates/yew "yew lib"

I recently learned of the Go board game.
If you are not familiar with the game, you have probably heard of it before
[when AlphaGo beat its best
player](https://en.wikipedia.org/wiki/AlphaGo_versus_Lee_Sedol).
I desired a four player implementation that was playable from a web browser.

Around the same time, I came across
[Pont][], an implementation of another board game that used Rust for both the 
server and client.
The server is multithreaded with an asynchronous runtime, and exposes a
WebSocket API that a client can interface with.
The client was written with [a Rust to JavaScript transpiler / Rust to 
WebAssembly compiler](https://crates.io/crates/wasm-bindgen).
I decided to write a Go stack in Rust, similar to what was done with [Pont][].

Rengo is a four player implementation of Go that does not alter the game logic.
Rather, two people on a single team take turns playing against another team of
two.
This preserves the two team, turn based gameplay.
[This][rengo] is the game that I implemented.

For the frontend, I used
[wasm-bindgen](https://crates.io/crates/wasm-bindgen),
[js-sys](https://crates.io/crates/js-sys), and
[web\_sys][].
I wrote a substantial amount of code that used functionality from [web\_sys][].
It provides a Rust interface to many of the common JavaScript functions that are
necessary to create an interactive WebSocket game.
For example, the crate enables dynamic resizing of site elements and fonts and
rendering of a canvas element.
I used [Bootstrap
4.5](https://getbootstrap.com/docs/4.5/getting-started/introduction/) to style
the page.
One problem I had when utilizing Bootstrap modals to notify the user
was that I had to call a function through JQuery to show the modal.
[js-sys](https://crates.io/crate/js-sys) allowed me to define a function
prototype to call the JQuery function.

For the backend, I used the same crates that [Pont][] used.
Namely, I used [smol](https://crates.io/crate/smol) as the asynchronous runtime, 
[async-tungstenite](https://crates.io/crates/async_tungstenite) as an
asynchronous WebSocket listener, and [bincode](https://crates.io/crates/bincode)
for binary data serialization to transmit Rust enums across WebSocket.
The server was generally straightforward.
My implementation allows for the creation of rooms, where player capacity can be
specified.
Rooms follow an actor model, where the connection handler messages a room to
request that an action be completed.

A substantial amount of boilerplate code was written.
[Actix][] could be used to elegantly write an
actor based concurrency model.
The client code contains some weird code, such as
this line
``` rust
ctx.fill_text(&format!("{}", i as u32 + 1), inner_begin + inner_size
+ 5_f64 * inner_begin / 9_f64 - font_size as f64 / 3_f64, inner_begin +
line_space * i as f64 + 8_f64 * font_size as f64 / 20_f64)?;
```
which is needed to properly align letters on the game board.
After writing [Rengo][rengo], I discovered [yew][],
which is a framework for writing interactive web applications in Rust.
It uses some macro generated syntax that functions similarly to
[JSX](https://reactjs.org/docs/introducing-jsx.html).

I am enjoying both Rust and Go quite a bit.
An idea that I have had is to write a more general and polished Go platform that
takes advantage of existing frameworks such as [Actix][] and [yew][].
If you are interested in Go, make sure to try [OGS](https://online-go.com),
which is a great Go platform for playing games against players and AI, with
built in game analysis.
