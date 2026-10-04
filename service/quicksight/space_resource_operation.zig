const SpaceQuickSightResourceDetails = @import("space_quick_sight_resource_details.zig").SpaceQuickSightResourceDetails;
const SpaceQuickSightResourceType = @import("space_quick_sight_resource_type.zig").SpaceQuickSightResourceType;

/// An operation to perform on a resource in a space.
pub const SpaceResourceOperation = struct {
    /// The details of the resource.
    resource_details: SpaceQuickSightResourceDetails,

    /// The type of the resource.
    resource_type: SpaceQuickSightResourceType,

    pub const json_field_names = .{
        .resource_details = "ResourceDetails",
        .resource_type = "ResourceType",
    };
};
