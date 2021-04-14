- The websockets don't work in wss on Firefox for some reason, they do work in
  Chrome and Safari.
- The `limbic/javascript/ethereum:sleected-address` caching isn't per
  connection, so that's causing all sorts of weirdness, this probably needs to
  be a CLOG `connection-data-item` or something like that.
- The price quotes in the Bitcoin menu should auto-update.
- There should be Ethereum price quotes vs. USD, gold, and silver under the
  Ethereum menu just like under Bitcoin.
- https://www.cryptonator.com/api is a very simple API for a lot of the other
  coins, we should use them.
