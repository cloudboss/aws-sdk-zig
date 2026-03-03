/// A placement constraint object to use for tasks.
pub const AwsEcsTaskDefinitionPlacementConstraintsDetails = struct {
    /// A cluster query language expression to apply to the constraint.
    expression: ?[]const u8 = null,

    /// The type of constraint.
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .expression = "Expression",
        .@"type" = "Type",
    };
};
