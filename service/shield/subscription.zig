const AutoRenew = @import("auto_renew.zig").AutoRenew;
const Limit = @import("limit.zig").Limit;
const ProactiveEngagementStatus = @import("proactive_engagement_status.zig").ProactiveEngagementStatus;
const SubscriptionLimits = @import("subscription_limits.zig").SubscriptionLimits;

/// Information about the Shield Advanced subscription for an account.
pub const Subscription = struct {
    /// If `ENABLED`, the subscription will be automatically renewed at the end of
    /// the existing subscription period.
    ///
    /// When you initally create a subscription, `AutoRenew` is set to `ENABLED`.
    /// You can change this by submitting an `UpdateSubscription` request. If the
    /// `UpdateSubscription` request does not included a value for `AutoRenew`, the
    /// existing value for `AutoRenew` remains unchanged.
    auto_renew: ?AutoRenew = null,

    /// The date and time your subscription will end.
    end_time: ?i64 = null,

    /// Specifies how many protections of a given type you can create.
    limits: ?[]const Limit = null,

    /// If `ENABLED`, the Shield Response Team (SRT) will use email and phone to
    /// notify contacts about escalations to the SRT and to initiate proactive
    /// customer support.
    ///
    /// If `PENDING`, you have requested proactive engagement and the request is
    /// pending. The status changes to `ENABLED` when your request is fully
    /// processed.
    ///
    /// If `DISABLED`, the SRT will not proactively notify contacts about
    /// escalations or to initiate proactive customer support.
    proactive_engagement_status: ?ProactiveEngagementStatus = null,

    /// The start time of the subscription, in Unix time in seconds.
    start_time: ?i64 = null,

    /// The ARN (Amazon Resource Name) of the subscription.
    subscription_arn: ?[]const u8 = null,

    /// Limits settings for your subscription.
    subscription_limits: SubscriptionLimits,

    /// The length, in seconds, of the Shield Advanced subscription for the account.
    time_commitment_in_seconds: i64 = 0,

    pub const json_field_names = .{
        .auto_renew = "AutoRenew",
        .end_time = "EndTime",
        .limits = "Limits",
        .proactive_engagement_status = "ProactiveEngagementStatus",
        .start_time = "StartTime",
        .subscription_arn = "SubscriptionArn",
        .subscription_limits = "SubscriptionLimits",
        .time_commitment_in_seconds = "TimeCommitmentInSeconds",
    };
};
