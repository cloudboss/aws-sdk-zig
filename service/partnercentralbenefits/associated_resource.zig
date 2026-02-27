const ResourceType = @import("resource_type.zig").ResourceType;

/// Represents an AWS resource that is associated with a benefit application for
/// tracking and management.
pub const AssociatedResource = struct {
    /// The Amazon Resource Name (ARN) that uniquely identifies the AWS resource.
    resource_arn: ?[]const u8,

    /// The unique identifier of the AWS resource within its service.
    resource_identifier: ?[]const u8,

    /// The type of AWS resource (e.g., EC2 instance, S3 bucket, Lambda function).
    resource_type: ?ResourceType,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .resource_identifier = "ResourceIdentifier",
        .resource_type = "ResourceType",
    };
};
