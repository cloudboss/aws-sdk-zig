const SubscriptionStatus = @import("subscription_status.zig").SubscriptionStatus;

/// Complete subscription resource data.
pub const SubscriptionDescription = struct {
    activated_at: ?i64 = null,

    arn: []const u8,

    created_at: i64,

    deactivated_at: ?i64 = null,

    domain_id: []const u8,

    last_updated_at: i64,

    status: SubscriptionStatus,

    subscription_id: []const u8,

    pub const json_field_names = .{
        .activated_at = "activatedAt",
        .arn = "arn",
        .created_at = "createdAt",
        .deactivated_at = "deactivatedAt",
        .domain_id = "domainId",
        .last_updated_at = "lastUpdatedAt",
        .status = "status",
        .subscription_id = "subscriptionId",
    };
};
