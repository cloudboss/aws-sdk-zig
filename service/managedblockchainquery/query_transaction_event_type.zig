pub const QueryTransactionEventType = enum {
    /// An ERC20 transfer type
    erc20_transfer,
    /// An ERC20_MINT transfer type
    erc20_mint,
    /// An ERC20_BURN transfer type
    erc20_burn,
    /// An ERC20_DEPOSIT transfer type
    erc20_deposit,
    /// An ERC20_WITHDRAWAL transfer type
    erc20_withdrawal,
    /// An ERC721 transfer type
    erc721_transfer,
    /// An ERC1155 transfer type
    erc1155_transfer,
    /// A Bitcoin Vin transfer type
    bitcoin_vin,
    /// A Bitcoin Vout transfer type
    bitcoin_vout,
    /// An internal ETH transfer type
    internal_eth_transfer,
    /// An ETH transfer type
    eth_transfer,

    pub const json_field_names = .{
        .erc20_transfer = "ERC20_TRANSFER",
        .erc20_mint = "ERC20_MINT",
        .erc20_burn = "ERC20_BURN",
        .erc20_deposit = "ERC20_DEPOSIT",
        .erc20_withdrawal = "ERC20_WITHDRAWAL",
        .erc721_transfer = "ERC721_TRANSFER",
        .erc1155_transfer = "ERC1155_TRANSFER",
        .bitcoin_vin = "BITCOIN_VIN",
        .bitcoin_vout = "BITCOIN_VOUT",
        .internal_eth_transfer = "INTERNAL_ETH_TRANSFER",
        .eth_transfer = "ETH_TRANSFER",
    };
};
