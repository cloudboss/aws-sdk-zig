const CapacityLimits = @import("capacity_limits.zig").CapacityLimits;

/// OpenSearch Serverless-related information for the current account.
pub const AccountSettingsDetail = struct {
    capacity_limits: ?CapacityLimits = null,

    pub const json_field_names = .{
        .capacity_limits = "capacityLimits",
    };
};
