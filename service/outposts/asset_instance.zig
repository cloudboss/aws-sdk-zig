const AWSServiceName = @import("aws_service_name.zig").AWSServiceName;

/// An Amazon EC2 instance.
pub const AssetInstance = struct {
    account_id: ?[]const u8,

    /// The ID of the asset. An Outpost asset can be a single server within an
    /// Outposts rack or an
    /// Outposts server configuration.
    asset_id: ?[]const u8,

    /// The Amazon Web Services service name of the instance.
    aws_service_name: ?AWSServiceName,

    /// The ID of the instance.
    instance_id: ?[]const u8,

    /// The type of instance.
    instance_type: ?[]const u8,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .asset_id = "AssetId",
        .aws_service_name = "AwsServiceName",
        .instance_id = "InstanceId",
        .instance_type = "InstanceType",
    };
};
