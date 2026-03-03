/// Consists of the logging role and the log group name.
pub const LoggingConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the Identity and Access Management (IAM)
    /// role that allows a server to turn on Amazon CloudWatch logging for Amazon S3
    /// or Amazon EFS events. When set, you can view user activity in your
    /// CloudWatch logs.
    logging_role: ?[]const u8 = null,

    /// The name of the CloudWatch logging group for the Transfer Family server to
    /// which this workflow belongs.
    log_group_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .logging_role = "LoggingRole",
        .log_group_name = "LogGroupName",
    };
};
