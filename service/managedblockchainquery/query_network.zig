pub const QueryNetwork = enum {
    /// Ethereum main network
    ethereum_mainnet,
    /// SEPOLIA network (ethereum testnet)
    ethereum_sepolia_testnet,
    /// Bitcoin main network
    bitcoin_mainnet,
    /// Bitcoin test network
    bitcoin_testnet,

    pub const json_field_names = .{
        .ethereum_mainnet = "ETHEREUM_MAINNET",
        .ethereum_sepolia_testnet = "ETHEREUM_SEPOLIA_TESTNET",
        .bitcoin_mainnet = "BITCOIN_MAINNET",
        .bitcoin_testnet = "BITCOIN_TESTNET",
    };
};
