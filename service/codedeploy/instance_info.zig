const Tag = @import("tag.zig").Tag;

/// Information about an on-premises instance.
pub const InstanceInfo = struct {
    /// If the on-premises instance was deregistered, the time at which the
    /// on-premises
    /// instance was deregistered.
    deregister_time: ?i64 = null,

    /// The ARN of the IAM session associated with the on-premises
    /// instance.
    iam_session_arn: ?[]const u8 = null,

    /// The user ARN associated with the on-premises instance.
    iam_user_arn: ?[]const u8 = null,

    /// The ARN of the on-premises instance.
    instance_arn: ?[]const u8 = null,

    /// The name of the on-premises instance.
    instance_name: ?[]const u8 = null,

    /// The time at which the on-premises instance was registered.
    register_time: ?i64 = null,

    /// The tags currently associated with the on-premises instance.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .deregister_time = "deregisterTime",
        .iam_session_arn = "iamSessionArn",
        .iam_user_arn = "iamUserArn",
        .instance_arn = "instanceArn",
        .instance_name = "instanceName",
        .register_time = "registerTime",
        .tags = "tags",
    };
};
