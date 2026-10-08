const ScheduledChange = @import("scheduled_change.zig").ScheduledChange;
const Status = @import("status.zig").Status;

/// Summary information for a flat-rate pricing subscription, as returned by
/// list operations.
pub const SubscriptionSummary = struct {
    /// The Amazon Resource Name (ARN) that uniquely identifies this subscription.
    arn: []const u8,

    /// The date and time when the subscription was created, in ISO 8601 format.
    created_at: i64,

    /// The entity tag for concurrency control. Pass this value in the `If-Match`
    /// header when making changes to this subscription.
    e_tag: []const u8,

    /// The pricing plan family for the subscription, such as `CloudFront`.
    plan_family: []const u8,

    /// The current tier level of the pricing plan.
    plan_tier: []const u8,

    /// The ARNs of the resources covered by this subscription.
    resource_arns: []const []const u8,

    /// A pending change that will take effect at the end of the current billing
    /// period, if any.
    scheduled_change: ?ScheduledChange = null,

    /// The current status of the subscription.
    status: Status,

    /// A human-readable explanation of the current status, present when additional
    /// context is available.
    status_reason: ?[]const u8 = null,

    /// The date and time when the subscription was last modified, in ISO 8601
    /// format.
    updated_at: i64,

    /// The usage level within the plan tier.
    usage_level: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .e_tag = "eTag",
        .plan_family = "planFamily",
        .plan_tier = "planTier",
        .resource_arns = "resourceArns",
        .scheduled_change = "scheduledChange",
        .status = "status",
        .status_reason = "statusReason",
        .updated_at = "updatedAt",
        .usage_level = "usageLevel",
    };
};
