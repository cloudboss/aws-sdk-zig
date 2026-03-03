/// Contains details about the credentials that Step Functions uses for a task.
pub const TaskCredentials = struct {
    /// The ARN of an IAM role that Step Functions assumes for the task. The role
    /// can allow cross-account access to resources.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .role_arn = "roleArn",
    };
};
