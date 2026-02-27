const Stage = @import("stage.zig").Stage;

/// Information about the stages and on-call rotation teams associated with an
/// escalation
/// plan or engagement plan.
pub const Plan = struct {
    /// The Amazon Resource Names (ARNs) of the on-call rotations associated with
    /// the plan.
    rotation_ids: ?[]const []const u8,

    /// A list of stages that the escalation plan or engagement plan uses to engage
    /// contacts and
    /// contact methods.
    stages: ?[]const Stage,

    pub const json_field_names = .{
        .rotation_ids = "RotationIds",
        .stages = "Stages",
    };
};
