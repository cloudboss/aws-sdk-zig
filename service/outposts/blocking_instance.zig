const AWSServiceName = @import("aws_service_name.zig").AWSServiceName;

/// A running Amazon EC2 instance that can be stopped to free up capacity needed
/// to run the
/// capacity task.
pub const BlockingInstance = struct {
    account_id: ?[]const u8,

    /// The Amazon Web Services service name that owns the specified blocking
    /// instance.
    aws_service_name: ?AWSServiceName,

    /// The ID of the blocking instance.
    instance_id: ?[]const u8,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .aws_service_name = "AwsServiceName",
        .instance_id = "InstanceId",
    };
};
