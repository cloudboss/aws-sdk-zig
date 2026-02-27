const BlueprintStage = @import("blueprint_stage.zig").BlueprintStage;

/// Summary of a Blueprint
pub const BlueprintSummary = struct {
    blueprint_arn: []const u8,

    blueprint_name: ?[]const u8,

    blueprint_stage: ?BlueprintStage,

    blueprint_version: ?[]const u8,

    creation_time: i64,

    last_modified_time: ?i64,

    pub const json_field_names = .{
        .blueprint_arn = "blueprintArn",
        .blueprint_name = "blueprintName",
        .blueprint_stage = "blueprintStage",
        .blueprint_version = "blueprintVersion",
        .creation_time = "creationTime",
        .last_modified_time = "lastModifiedTime",
    };
};
