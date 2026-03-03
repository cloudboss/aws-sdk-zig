const UserIdentity = @import("user_identity.zig").UserIdentity;

/// Description of the VPC connection.
pub const VpcConnectionInfo = struct {
    /// The time when Amazon MSK creates the VPC Connnection.
    creation_time: ?i64 = null,

    /// The owner of the VPC Connection.
    owner: ?[]const u8 = null,

    /// Description of the requester that calls the API operation.
    user_identity: ?UserIdentity = null,

    /// The Amazon Resource Name (ARN) of the VPC connection.
    vpc_connection_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .owner = "Owner",
        .user_identity = "UserIdentity",
        .vpc_connection_arn = "VpcConnectionArn",
    };
};
