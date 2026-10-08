/// Represents an AWS resource discovered by Resilience Hub.
pub const Resource = struct {
    /// The AWS account ID that owns the resource.
    aws_account_id: ?[]const u8 = null,

    /// The AWS Region where the resource is located.
    aws_region: ?[]const u8 = null,

    /// The identifier of the resource.
    identifier: []const u8,

    /// The type of the resource.
    resource_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .aws_account_id = "awsAccountId",
        .aws_region = "awsRegion",
        .identifier = "identifier",
        .resource_type = "resourceType",
    };
};
