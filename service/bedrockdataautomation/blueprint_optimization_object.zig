const BlueprintStage = @import("blueprint_stage.zig").BlueprintStage;

/// Structure for single blueprint entity.
pub const BlueprintOptimizationObject = struct {
    /// Arn of blueprint.
    blueprint_arn: []const u8,

    /// Stage of blueprint.
    stage: ?BlueprintStage = null,

    pub const json_field_names = .{
        .blueprint_arn = "blueprintArn",
        .stage = "stage",
    };
};
