/// A subscription for an Add On representing the acceptance of its terms of use
/// and additional pricing.
pub const AddonSubscription = struct {
    /// The name of the Add On.
    addon_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Add On subscription.
    addon_subscription_arn: ?[]const u8 = null,

    /// The unique ID of the Add On subscription.
    addon_subscription_id: ?[]const u8 = null,

    /// The timestamp of when the Add On subscription was created.
    created_timestamp: ?i64 = null,

    pub const json_field_names = .{
        .addon_name = "AddonName",
        .addon_subscription_arn = "AddonSubscriptionArn",
        .addon_subscription_id = "AddonSubscriptionId",
        .created_timestamp = "CreatedTimestamp",
    };
};
