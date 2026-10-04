const BlueprintItem = @import("blueprint_item.zig").BlueprintItem;

/// Custom Configuration of Document
pub const DocumentCustomOutputConfiguration = struct {
    fallback_blueprints: ?[]const BlueprintItem = null,

    pub const json_field_names = .{
        .fallback_blueprints = "fallbackBlueprints",
    };
};
