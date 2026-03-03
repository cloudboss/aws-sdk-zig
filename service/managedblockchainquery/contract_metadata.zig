/// The metadata of the contract.
pub const ContractMetadata = struct {
    /// The decimals used by the token contract.
    decimals: ?i32 = null,

    /// The name of the token contract.
    name: ?[]const u8 = null,

    /// The symbol of the token contract.
    symbol: ?[]const u8 = null,

    pub const json_field_names = .{
        .decimals = "decimals",
        .name = "name",
        .symbol = "symbol",
    };
};
