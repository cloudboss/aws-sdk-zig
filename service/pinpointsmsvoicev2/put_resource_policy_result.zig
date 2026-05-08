pub const PutResourcePolicyResult = struct {
    /// The time when the resource-based policy was created, in [UNIX epoch
    /// time](https://www.epochconverter.com/) format.
    created_timestamp: ?i64 = null,

    /// The JSON formatted Resource Policy.
    policy: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the End User Messaging SMS resource
    /// attached to the resource-based policy.
    resource_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_timestamp = "CreatedTimestamp",
        .policy = "Policy",
        .resource_arn = "ResourceArn",
    };
};
