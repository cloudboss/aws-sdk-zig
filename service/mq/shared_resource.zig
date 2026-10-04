const SharedResourceError = @import("shared_resource_error.zig").SharedResourceError;
const SharedResourceStatus = @import("shared_resource_status.zig").SharedResourceStatus;
const SharedResourceType = @import("shared_resource_type.zig").SharedResourceType;

/// Represents a resource that is shared with the broker, including its type,
/// ARN, and current status.
pub const SharedResource = struct {
    /// The DNS names accessible by the broker.
    dns_names: ?[]const []const u8 = null,

    /// Information on the error encountered by the resource.
    @"error": ?SharedResourceError = null,

    /// The ARN of the shared resource.
    resource_arn: []const u8,

    /// The resource share ARNs to which the resource belongs.
    resource_share_arns: ?[]const []const u8 = null,

    /// The status of the shared resource.
    status: SharedResourceStatus,

    /// The type of shared resource.
    @"type": SharedResourceType,

    pub const json_field_names = .{
        .dns_names = "DnsNames",
        .@"error" = "Error",
        .resource_arn = "ResourceArn",
        .resource_share_arns = "ResourceShareArns",
        .status = "Status",
        .@"type" = "Type",
    };
};
