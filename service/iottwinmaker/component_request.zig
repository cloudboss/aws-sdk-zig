const aws = @import("aws");

const PropertyRequest = @import("property_request.zig").PropertyRequest;
const ComponentPropertyGroupRequest = @import("component_property_group_request.zig").ComponentPropertyGroupRequest;

/// An object that sets information about a component type create or update
/// request.
pub const ComponentRequest = struct {
    /// The ID of the component type.
    component_type_id: ?[]const u8,

    /// The description of the component request.
    description: ?[]const u8,

    /// An object that maps strings to the properties to set in the component type.
    /// Each string
    /// in the mapping must be unique to this object.
    properties: ?[]const aws.map.MapEntry(PropertyRequest),

    /// The property groups.
    property_groups: ?[]const aws.map.MapEntry(ComponentPropertyGroupRequest),

    pub const json_field_names = .{
        .component_type_id = "componentTypeId",
        .description = "description",
        .properties = "properties",
        .property_groups = "propertyGroups",
    };
};
