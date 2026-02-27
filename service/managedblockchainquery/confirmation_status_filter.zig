const ConfirmationStatus = @import("confirmation_status.zig").ConfirmationStatus;

/// The container for the `ConfirmationStatusFilter` that filters for the [
/// *finality*
/// ](https://docs.aws.amazon.com/managed-blockchain/latest/ambq-dg/key-concepts.html#finality) of the results.
pub const ConfirmationStatusFilter = struct {
    /// The container to determine whether to list results that have only reached [
    /// *finality*
    /// ](https://docs.aws.amazon.com/managed-blockchain/latest/ambq-dg/key-concepts.html#finality). Transactions
    /// that have reached finality are always part of the response.
    include: []const ConfirmationStatus,

    pub const json_field_names = .{
        .include = "include",
    };
};
