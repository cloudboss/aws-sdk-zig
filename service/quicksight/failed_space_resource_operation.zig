const SpaceQuickSightResourceDetails = @import("space_quick_sight_resource_details.zig").SpaceQuickSightResourceDetails;
const SpaceQuickSightResourceType = @import("space_quick_sight_resource_type.zig").SpaceQuickSightResourceType;

/// A resource operation that failed.
pub const FailedSpaceResourceOperation = struct {
    /// The error message that describes why the operation failed.
    error_message: []const u8,

    /// The details of the resource.
    resource_details: ?SpaceQuickSightResourceDetails = null,

    /// The type of the resource.
    resource_type: SpaceQuickSightResourceType,

    pub const json_field_names = .{
        .error_message = "ErrorMessage",
        .resource_details = "ResourceDetails",
        .resource_type = "ResourceType",
    };
};
