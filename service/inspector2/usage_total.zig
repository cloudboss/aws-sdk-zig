const Usage = @import("usage.zig").Usage;

/// The total of usage for an account ID.
pub const UsageTotal = struct {
    /// The account ID of the account that usage data was retrieved for.
    account_id: ?[]const u8,

    /// An object representing the total usage for an account.
    usage: ?[]const Usage,

    pub const json_field_names = .{
        .account_id = "accountId",
        .usage = "usage",
    };
};
