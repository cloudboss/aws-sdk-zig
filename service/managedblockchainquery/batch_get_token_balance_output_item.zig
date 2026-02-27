const BlockchainInstant = @import("blockchain_instant.zig").BlockchainInstant;
const OwnerIdentifier = @import("owner_identifier.zig").OwnerIdentifier;
const TokenIdentifier = @import("token_identifier.zig").TokenIdentifier;

/// The container for the properties of a token balance output.
pub const BatchGetTokenBalanceOutputItem = struct {
    at_blockchain_instant: BlockchainInstant,

    /// The container for the token balance.
    balance: []const u8,

    last_updated_time: ?BlockchainInstant,

    owner_identifier: ?OwnerIdentifier,

    token_identifier: ?TokenIdentifier,

    pub const json_field_names = .{
        .at_blockchain_instant = "atBlockchainInstant",
        .balance = "balance",
        .last_updated_time = "lastUpdatedTime",
        .owner_identifier = "ownerIdentifier",
        .token_identifier = "tokenIdentifier",
    };
};
