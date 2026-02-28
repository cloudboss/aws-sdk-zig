const ShareStatus = @import("share_status.zig").ShareStatus;
const ShareResourceType = @import("share_resource_type.zig").ShareResourceType;

/// Use filters to return a subset of resources. You can define filters for
/// specific parameters, such as the resource status.
pub const Filter = struct {
    /// Filter based on the Amazon Resource Number (ARN) of the resource. You can
    /// specify up to 10 values.
    resource_arns: ?[]const []const u8,

    /// Filter based on the resource status. You can specify up to 10 values.
    status: ?[]const ShareStatus,

    /// The type of resources to be filtered. You can specify one or more of the
    /// resource types.
    @"type": ?[]const ShareResourceType,

    pub const json_field_names = .{
        .resource_arns = "resourceArns",
        .status = "status",
        .@"type" = "type",
    };
};
