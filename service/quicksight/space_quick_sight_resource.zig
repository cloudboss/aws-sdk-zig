const SpaceQuickSightResourceDetails = @import("space_quick_sight_resource_details.zig").SpaceQuickSightResourceDetails;
const SpaceQuickSightResourceType = @import("space_quick_sight_resource_type.zig").SpaceQuickSightResourceType;

/// A QuickSight resource that is associated with a space.
pub const SpaceQuickSightResource = struct {
    /// The details of the QuickSight resource.
    resource_details: SpaceQuickSightResourceDetails,

    /// The type of the QuickSight resource.
    resource_type: SpaceQuickSightResourceType,

    pub const json_field_names = .{
        .resource_details = "resourceDetails",
        .resource_type = "resourceType",
    };
};
