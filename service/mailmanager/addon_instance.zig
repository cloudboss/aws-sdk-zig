/// An Add On instance represents a specific configuration of an Add On.
pub const AddonInstance = struct {
    /// The Amazon Resource Name (ARN) of the Add On instance.
    addon_instance_arn: ?[]const u8,

    /// The unique ID of the Add On instance.
    addon_instance_id: ?[]const u8,

    /// The name of the Add On for the instance.
    addon_name: ?[]const u8,

    /// The subscription ID for the instance.
    addon_subscription_id: ?[]const u8,

    /// The timestamp of when the Add On instance was created.
    created_timestamp: ?i64,

    pub const json_field_names = .{
        .addon_instance_arn = "AddonInstanceArn",
        .addon_instance_id = "AddonInstanceId",
        .addon_name = "AddonName",
        .addon_subscription_id = "AddonSubscriptionId",
        .created_timestamp = "CreatedTimestamp",
    };
};
