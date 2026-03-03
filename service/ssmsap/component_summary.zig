const aws = @import("aws");

const ComponentType = @import("component_type.zig").ComponentType;

/// The summary of the component.
pub const ComponentSummary = struct {
    /// The ID of the application.
    application_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the component summary.
    arn: ?[]const u8 = null,

    /// The ID of the component.
    component_id: ?[]const u8 = null,

    /// The type of the component.
    component_type: ?ComponentType = null,

    /// The tags of the component.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .arn = "Arn",
        .component_id = "ComponentId",
        .component_type = "ComponentType",
        .tags = "Tags",
    };
};
