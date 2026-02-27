/// A placement constraint for the tasks in the service.
pub const AwsEcsServicePlacementConstraintsDetails = struct {
    /// A cluster query language expression to apply to the constraint. You cannot
    /// specify an expression if the constraint type is `distinctInstance`.
    expression: ?[]const u8,

    /// The type of constraint. Use `distinctInstance` to run each task in a
    /// particular group on a different container instance. Use `memberOf` to
    /// restrict the selection to a group of valid candidates.
    ///
    /// Valid values: `distinctInstance` | `memberOf`
    type: ?[]const u8,

    pub const json_field_names = .{
        .expression = "Expression",
        .type = "Type",
    };
};
