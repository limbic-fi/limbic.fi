# Add identicons to the ethereum wallets.

This will allow for the user to more easily determine that they are using the correct wallet.

This should probably show up to the left of the `Connected!` text in the Ethereum menu when connected.

## Which identicon to use?

https://github.com/ethereum/blockies

Maybe https://github.com/dmester/jdenticon  / https://jdenticon.com/ instead?

### Jazzicon, to match Uniswap?

It looks like Uniswap uses Jazzicon.

```
      ref.current.appendChild(Jazzicon(16, parseInt(account.slice(2, 10), 16)))
```

https://github.com/Uniswap/uniswap-interface/blob/main/src/components/Identicon/index.tsx

```
    "jazzicon": "^1.5.0",
```

https://github.com/Uniswap/uniswap-interface/blob/main/package.json

https://www.npmjs.com/package/@metamask/jazzicon

https://github.com/MetaMask/jazzicon

But that seems to be only NPM/Node.JS, not browser JavaScript?

### Decision

Let's go with `ethereum/blockies`, mostly just because

- It's officially(-ish) from Ethereum
- It's browser friendly
