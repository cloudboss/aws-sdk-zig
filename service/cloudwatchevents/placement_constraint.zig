const PlacementConstraintType = @import("placement_constraint_type.zig").PlacementConstraintType;

/// An object representing a constraint on task placement. To learn more, see
/// [Task Placement
/// Constraints](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-placement-constraints.html) in the Amazon Elastic Container Service Developer
/// Guide.
pub const PlacementConstraint = struct {
    /// A cluster query language expression to apply to the constraint. You cannot
    /// specify an
    /// expression if the constraint type is `distinctInstance`. To learn more, see
    /// [Cluster Query
    /// Language](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/cluster-query-language.html) in the Amazon Elastic Container Service Developer Guide.
    expression: ?[]const u8,

    /// The type of constraint. Use distinctInstance to ensure that each task in a
    /// particular
    /// group is running on a different container instance. Use memberOf to restrict
    /// the selection to
    /// a group of valid candidates.
    @"type": ?PlacementConstraintType,

    pub const json_field_names = .{
        .expression = "expression",
        .@"type" = "type",
    };
};
