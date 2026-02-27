const TaskDefinitionPlacementConstraintType = @import("task_definition_placement_constraint_type.zig").TaskDefinitionPlacementConstraintType;

/// The constraint on task placement in the task definition. For more
/// information, see
/// [Task placement
/// constraints](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-placement-constraints.html) in the *Amazon
/// Elastic Container Service Developer Guide*.
///
/// Task placement constraints aren't supported for tasks run on Fargate.
pub const TaskDefinitionPlacementConstraint = struct {
    /// A cluster query language expression to apply to the constraint. For more
    /// information,
    /// see [Cluster query
    /// language](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/cluster-query-language.html) in the *Amazon Elastic
    /// Container Service Developer Guide*.
    expression: ?[]const u8,

    /// The type of constraint. The `MemberOf` constraint restricts selection to be
    /// from a group of valid candidates.
    type: ?TaskDefinitionPlacementConstraintType,

    pub const json_field_names = .{
        .expression = "expression",
        .type = "type",
    };
};
