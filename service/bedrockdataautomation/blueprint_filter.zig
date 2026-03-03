const BlueprintStage = @import("blueprint_stage.zig").BlueprintStage;

/// Blueprint Filter
pub const BlueprintFilter = struct {
    blueprint_arn: []const u8,

    blueprint_stage: ?BlueprintStage = null,

    blueprint_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .blueprint_arn = "blueprintArn",
        .blueprint_stage = "blueprintStage",
        .blueprint_version = "blueprintVersion",
    };
};
