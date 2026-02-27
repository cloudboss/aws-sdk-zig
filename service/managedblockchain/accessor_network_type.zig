pub const AccessorNetworkType = enum {
    ethereum_goerli,
    ethereum_mainnet,
    ethereum_mainnet_and_goerli,
    polygon_mainnet,
    polygon_mumbai,

    pub const json_field_names = .{
        .ethereum_goerli = "ETHEREUM_GOERLI",
        .ethereum_mainnet = "ETHEREUM_MAINNET",
        .ethereum_mainnet_and_goerli = "ETHEREUM_MAINNET_AND_GOERLI",
        .polygon_mainnet = "POLYGON_MAINNET",
        .polygon_mumbai = "POLYGON_MUMBAI",
    };
};
