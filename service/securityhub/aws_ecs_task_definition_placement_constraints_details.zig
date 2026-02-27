/// A placement constraint object to use for tasks.
pub const AwsEcsTaskDefinitionPlacementConstraintsDetails = struct {
    /// A cluster query language expression to apply to the constraint.
    expression: ?[]const u8,

    /// The type of constraint.
    type: ?[]const u8,

    pub const json_field_names = .{
        .expression = "Expression",
        .type = "Type",
    };
};
