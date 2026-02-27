const AutoSubscriptionStatus = @import("auto_subscription_status.zig").AutoSubscriptionStatus;
const SubscriptionType = @import("subscription_type.zig").SubscriptionType;

/// Subscription configuration information for an Amazon Q Business application
/// using IAM identity federation for user management.
pub const AutoSubscriptionConfiguration = struct {
    /// Describes whether automatic subscriptions are enabled for an Amazon Q
    /// Business application using IAM identity federation for user management.
    auto_subscribe: AutoSubscriptionStatus,

    /// Describes the default subscription type assigned to an Amazon Q Business
    /// application using IAM identity federation for user management. If the value
    /// for `autoSubscribe` is set to `ENABLED` you must select a value for this
    /// field.
    default_subscription_type: ?SubscriptionType,

    pub const json_field_names = .{
        .auto_subscribe = "autoSubscribe",
        .default_subscription_type = "defaultSubscriptionType",
    };
};
