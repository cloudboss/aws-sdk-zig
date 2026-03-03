const EvaluationType = @import("evaluation_type.zig").EvaluationType;
const ResourceTargetDefinition = @import("resource_target_definition.zig").ResourceTargetDefinition;

/// Information about a change to a resource attribute.
pub const ResourceChangeDetail = struct {
    /// The ID of the entity that caused the change.
    causing_entity: ?[]const u8 = null,

    /// For static evaluations, the value of the resource attribute will change and
    /// the new value is known.
    /// For dynamic evaluations, the value might change, and any new value will be
    /// determined when the plan is updated.
    evaluation: ?EvaluationType = null,

    /// Information about the resource attribute to be modified.
    target: ?ResourceTargetDefinition = null,

    pub const json_field_names = .{
        .causing_entity = "CausingEntity",
        .evaluation = "Evaluation",
        .target = "Target",
    };
};
