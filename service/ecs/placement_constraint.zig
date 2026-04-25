const PlacementConstraintType = @import("placement_constraint_type.zig").PlacementConstraintType;

/// An object representing a constraint on task placement. For more information,
/// see [Task placement
/// constraints](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-placement-constraints.html) in the *Amazon Elastic Container Service Developer Guide*.
///
/// If you're using the Fargate launch type, task placement constraints aren't
/// supported.
pub const PlacementConstraint = struct {
    /// A cluster query language expression to apply to the constraint. The
    /// expression can have a maximum length of 2000 characters. You can't specify
    /// an expression if the constraint type is `distinctInstance`. For more
    /// information, see [Cluster query
    /// language](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/cluster-query-language.html) in the *Amazon Elastic Container Service Developer Guide*.
    expression: ?[]const u8 = null,

    /// The type of constraint. Use `distinctInstance` to ensure that each task in a
    /// particular group is running on a different container instance. Use
    /// `memberOf` to restrict the selection to a group of valid candidates.
    @"type": ?PlacementConstraintType = null,

    pub const json_field_names = .{
        .expression = "expression",
        .@"type" = "type",
    };
};
