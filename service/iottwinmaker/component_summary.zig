const aws = @import("aws");

const ComponentPropertyGroupResponse = @import("component_property_group_response.zig").ComponentPropertyGroupResponse;
const Status = @import("status.zig").Status;

/// An object that returns information about a component summary.
pub const ComponentSummary = struct {
    /// The name of the component.
    component_name: []const u8,

    /// This string specifies the path to the composite component, starting from the
    /// top-level component.
    component_path: ?[]const u8,

    /// The ID of the component type.
    component_type_id: []const u8,

    /// The name of the property definition set in the request.
    defined_in: ?[]const u8,

    /// The description of the component request.
    description: ?[]const u8,

    /// The property groups.
    property_groups: ?[]const aws.map.MapEntry(ComponentPropertyGroupResponse),

    /// The status of the component type.
    status: Status,

    /// The `syncSource` of the sync job, if this entity was created by a sync job.
    sync_source: ?[]const u8,

    pub const json_field_names = .{
        .component_name = "componentName",
        .component_path = "componentPath",
        .component_type_id = "componentTypeId",
        .defined_in = "definedIn",
        .description = "description",
        .property_groups = "propertyGroups",
        .status = "status",
        .sync_source = "syncSource",
    };
};
