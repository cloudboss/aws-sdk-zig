const BlockchainInstant = @import("blockchain_instant.zig").BlockchainInstant;
const ErrorType = @import("error_type.zig").ErrorType;
const OwnerIdentifier = @import("owner_identifier.zig").OwnerIdentifier;
const TokenIdentifier = @import("token_identifier.zig").TokenIdentifier;

/// Error generated from a failed `BatchGetTokenBalance` request.
pub const BatchGetTokenBalanceErrorItem = struct {
    at_blockchain_instant: ?BlockchainInstant = null,

    /// The error code associated with the error.
    error_code: []const u8,

    /// The message associated with the error.
    error_message: []const u8,

    /// The type of error.
    error_type: ErrorType,

    owner_identifier: ?OwnerIdentifier = null,

    token_identifier: ?TokenIdentifier = null,

    pub const json_field_names = .{
        .at_blockchain_instant = "atBlockchainInstant",
        .error_code = "errorCode",
        .error_message = "errorMessage",
        .error_type = "errorType",
        .owner_identifier = "ownerIdentifier",
        .token_identifier = "tokenIdentifier",
    };
};
