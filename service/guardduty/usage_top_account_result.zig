const Total = @import("total.zig").Total;

/// Contains information on the total of usage based on the topmost 50
/// account IDs.
pub const UsageTopAccountResult = struct {
    /// The unique account ID.
    account_id: ?[]const u8,

    total: ?Total,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .total = "Total",
    };
};
