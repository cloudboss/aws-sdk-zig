const SpaceQuickSightResourceDetails = @import("space_quick_sight_resource_details.zig").SpaceQuickSightResourceDetails;
const SpaceQuickSightResourceType = @import("space_quick_sight_resource_type.zig").SpaceQuickSightResourceType;

/// A summary of a resource in a space.
pub const SpaceResourceSummary = struct {
    /// The details of the resource.
    resource_details: SpaceQuickSightResourceDetails,

    /// The name of the resource.
    resource_name: ?[]const u8 = null,

    /// The type of the resource.
    resource_type: SpaceQuickSightResourceType,

    /// The date and time that the resource was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .resource_details = "ResourceDetails",
        .resource_name = "ResourceName",
        .resource_type = "ResourceType",
        .updated_at = "UpdatedAt",
    };
};
