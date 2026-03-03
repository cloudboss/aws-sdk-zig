/// Contains a summary of a DB parameter group.
pub const DbParameterGroupSummary = struct {
    /// The Amazon Resource Name (ARN) of the DB parameter group.
    arn: []const u8,

    /// A description of the DB parameter group.
    description: ?[]const u8 = null,

    /// A service-generated unique identifier.
    id: []const u8,

    /// This customer-supplied name uniquely identifies the parameter group.
    name: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .description = "description",
        .id = "id",
        .name = "name",
    };
};
