const aws = @import("aws");

const ComponentPropertyGroupRequest = @import("component_property_group_request.zig").ComponentPropertyGroupRequest;
const PropertyRequest = @import("property_request.zig").PropertyRequest;
const ComponentUpdateType = @import("component_update_type.zig").ComponentUpdateType;

/// An object that sets information about the composite component update
/// request.
pub const CompositeComponentUpdateRequest = struct {
    /// The description of the component type.
    description: ?[]const u8,

    /// The property group updates.
    property_group_updates: ?[]const aws.map.MapEntry(ComponentPropertyGroupRequest),

    /// An object that maps strings to the properties to set in the component type
    /// update. Each string in the mapping must be unique to this object.
    property_updates: ?[]const aws.map.MapEntry(PropertyRequest),

    /// The update type of the component update request.
    update_type: ?ComponentUpdateType,

    pub const json_field_names = .{
        .description = "description",
        .property_group_updates = "propertyGroupUpdates",
        .property_updates = "propertyUpdates",
        .update_type = "updateType",
    };
};
