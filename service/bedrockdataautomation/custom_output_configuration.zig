const BlueprintItem = @import("blueprint_item.zig").BlueprintItem;
const DocumentCustomOutputConfiguration = @import("document_custom_output_configuration.zig").DocumentCustomOutputConfiguration;

/// Custom output configuration
pub const CustomOutputConfiguration = struct {
    blueprints: ?[]const BlueprintItem = null,

    document: ?DocumentCustomOutputConfiguration = null,

    pub const json_field_names = .{
        .blueprints = "blueprints",
        .document = "document",
    };
};
