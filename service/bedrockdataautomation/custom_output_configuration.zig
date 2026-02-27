const BlueprintItem = @import("blueprint_item.zig").BlueprintItem;

/// Custom output configuration
pub const CustomOutputConfiguration = struct {
    blueprints: ?[]const BlueprintItem,

    pub const json_field_names = .{
        .blueprints = "blueprints",
    };
};
