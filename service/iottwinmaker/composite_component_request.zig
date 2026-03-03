const aws = @import("aws");

const PropertyRequest = @import("property_request.zig").PropertyRequest;
const ComponentPropertyGroupRequest = @import("component_property_group_request.zig").ComponentPropertyGroupRequest;

/// An object that sets information about the composite component update
/// request.
pub const CompositeComponentRequest = struct {
    /// The description of the component type.
    description: ?[]const u8 = null,

    /// This is an object that maps strings to the properties to set in the
    /// component type. Each string in
    /// the mapping must be unique to this object.
    properties: ?[]const aws.map.MapEntry(PropertyRequest) = null,

    /// The property groups.
    property_groups: ?[]const aws.map.MapEntry(ComponentPropertyGroupRequest) = null,

    pub const json_field_names = .{
        .description = "description",
        .properties = "properties",
        .property_groups = "propertyGroups",
    };
};
