const aws = @import("aws");

const ComponentSummary = @import("component_summary.zig").ComponentSummary;
const PropertyResponse = @import("property_response.zig").PropertyResponse;
const ComponentPropertyGroupResponse = @import("component_property_group_response.zig").ComponentPropertyGroupResponse;
const Status = @import("status.zig").Status;

/// An object that returns information about a component type create or update
/// request.
pub const ComponentResponse = struct {
    /// This flag notes whether all `compositeComponents` are returned in the API
    /// response.
    are_all_composite_components_returned: ?bool,

    /// This flag notes whether all properties of the component are returned in the
    /// API response.
    /// The maximum number of properties returned is 800.
    are_all_properties_returned: ?bool,

    /// The name of the component.
    component_name: ?[]const u8,

    /// The ID of the component type.
    component_type_id: ?[]const u8,

    /// This lists objects that contain information about the `compositeComponents`.
    composite_components: ?[]const aws.map.MapEntry(ComponentSummary),

    /// The name of the property definition set in the request.
    defined_in: ?[]const u8,

    /// The description of the component type.
    description: ?[]const u8,

    /// An object that maps strings to the properties to set in the component type.
    /// Each string
    /// in the mapping must be unique to this object.
    properties: ?[]const aws.map.MapEntry(PropertyResponse),

    /// The property groups.
    property_groups: ?[]const aws.map.MapEntry(ComponentPropertyGroupResponse),

    /// The status of the component type.
    status: ?Status,

    /// The syncSource of the sync job, if this entity was created by a sync job.
    sync_source: ?[]const u8,

    pub const json_field_names = .{
        .are_all_composite_components_returned = "areAllCompositeComponentsReturned",
        .are_all_properties_returned = "areAllPropertiesReturned",
        .component_name = "componentName",
        .component_type_id = "componentTypeId",
        .composite_components = "compositeComponents",
        .defined_in = "definedIn",
        .description = "description",
        .properties = "properties",
        .property_groups = "propertyGroups",
        .status = "status",
        .sync_source = "syncSource",
    };
};
