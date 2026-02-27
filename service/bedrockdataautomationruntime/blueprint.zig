const BlueprintStage = @import("blueprint_stage.zig").BlueprintStage;

/// Structure for single blueprint entity.
pub const Blueprint = struct {
    /// Arn of blueprint.
    blueprint_arn: []const u8,

    /// Stage of blueprint.
    stage: ?BlueprintStage,

    /// Version of blueprint.
    version: ?[]const u8,

    pub const json_field_names = .{
        .blueprint_arn = "blueprintArn",
        .stage = "stage",
        .version = "version",
    };
};
