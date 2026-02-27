const ContractIdentifier = @import("contract_identifier.zig").ContractIdentifier;
const QueryTokenStandard = @import("query_token_standard.zig").QueryTokenStandard;

/// This container contains information about an contract.
pub const AssetContract = struct {
    /// The container for the contract identifier containing its blockchain network
    /// and address.
    contract_identifier: ContractIdentifier,

    /// The address of the contract deployer.
    deployer_address: []const u8,

    /// The token standard of the contract.
    token_standard: QueryTokenStandard,

    pub const json_field_names = .{
        .contract_identifier = "contractIdentifier",
        .deployer_address = "deployerAddress",
        .token_standard = "tokenStandard",
    };
};
