const ScheduledChange = @import("scheduled_change.zig").ScheduledChange;
const Status = @import("status.zig").Status;

/// The full details of a flat-rate pricing subscription, including its current
/// configuration, status, and associated resources.
pub const Subscription = struct {
    /// The Amazon Resource Name (ARN) that uniquely identifies this subscription.
    arn: []const u8,

    /// The date and time when the subscription was created, in ISO 8601 format.
    created_at: i64,

    /// The pricing plan family for the subscription, such as `CloudFront`.
    plan_family: []const u8,

    /// The current tier level of the pricing plan, such as `FREE`, `PRO`,
    /// `BUSINESS`, or `PREMIUM`.
    plan_tier: []const u8,

    /// The ARNs of the resources covered by this subscription.
    resource_arns: []const []const u8,

    /// A pending change that will take effect at the end of the current billing
    /// period. This field is present only when a downgrade or cancellation is
    /// scheduled.
    scheduled_change: ?ScheduledChange = null,

    /// The current status of the subscription. For the list of possible values, see
    /// the `Status` type.
    status: Status,

    /// A human-readable explanation of the current status, present when additional
    /// context is available.
    status_reason: ?[]const u8 = null,

    /// The date and time when the subscription was last modified, in ISO 8601
    /// format.
    updated_at: i64,

    /// The usage level within the plan tier. When present, indicates a specific
    /// capacity configuration beyond the base tier.
    usage_level: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
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
