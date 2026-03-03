/// Attributes of Ethereum for a network.
pub const NetworkEthereumAttributes = struct {
    /// The Ethereum `CHAIN_ID` associated with the Ethereum network. Chain IDs are
    /// as follows:
    ///
    /// * mainnet = `1`
    chain_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .chain_id = "ChainId",
    };
};
