/// A structure describing the current state of the model in its life cycle.
pub const ModelLifeCycle = struct {
    /// The current stage in the model life cycle.
    stage: []const u8,

    /// Describes the stage related details.
    stage_description: ?[]const u8,

    /// The current status of a stage in model life cycle.
    stage_status: []const u8,

    pub const json_field_names = .{
        .stage = "Stage",
        .stage_description = "StageDescription",
        .stage_status = "StageStatus",
    };
};
