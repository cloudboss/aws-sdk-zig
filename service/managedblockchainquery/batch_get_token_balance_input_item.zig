const BlockchainInstant = @import("blockchain_instant.zig").BlockchainInstant;
const OwnerIdentifier = @import("owner_identifier.zig").OwnerIdentifier;
const TokenIdentifier = @import("token_identifier.zig").TokenIdentifier;

/// The container for the input for getting a token balance.
pub const BatchGetTokenBalanceInputItem = struct {
    at_blockchain_instant: ?BlockchainInstant,

    owner_identifier: OwnerIdentifier,

    token_identifier: TokenIdentifier,

    pub const json_field_names = .{
        .at_blockchain_instant = "atBlockchainInstant",
        .owner_identifier = "ownerIdentifier",
        .token_identifier = "tokenIdentifier",
    };
};
