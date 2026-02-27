const BlockchainInstant = @import("blockchain_instant.zig").BlockchainInstant;
const OwnerIdentifier = @import("owner_identifier.zig").OwnerIdentifier;
const TokenIdentifier = @import("token_identifier.zig").TokenIdentifier;

/// The balance of the token.
pub const TokenBalance = struct {
    /// The time for when the TokenBalance is requested or
    /// the current time if a time is not provided in the request.
    ///
    /// This time will only be recorded up to the second.
    at_blockchain_instant: BlockchainInstant,

    /// The container of the token balance.
    balance: []const u8,

    /// The `Timestamp` of the last transaction at which the balance for the token
    /// in the wallet was updated.
    last_updated_time: ?BlockchainInstant,

    /// The container for the identifier of the owner.
    owner_identifier: ?OwnerIdentifier,

    /// The identifier for the token, including the unique token ID and its
    /// blockchain network.
    token_identifier: ?TokenIdentifier,

    pub const json_field_names = .{
        .at_blockchain_instant = "atBlockchainInstant",
        .balance = "balance",
        .last_updated_time = "lastUpdatedTime",
        .owner_identifier = "ownerIdentifier",
        .token_identifier = "tokenIdentifier",
    };
};
