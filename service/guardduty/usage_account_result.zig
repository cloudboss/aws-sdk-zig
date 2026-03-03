const Total = @import("total.zig").Total;

/// Contains information on the total of usage based on account IDs.
pub const UsageAccountResult = struct {
    /// The Account ID that generated usage.
    account_id: ?[]const u8 = null,

    /// Represents the total of usage for the Account ID.
    total: ?Total = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .total = "Total",
    };
};
