/// A group of signals that are defined in a hierarchical structure.
pub const Branch = struct {
    /// A comment in addition to the description.
    comment: ?[]const u8,

    /// The deprecation message for the node or the branch that was moved or
    /// deleted.
    deprecation_message: ?[]const u8,

    /// A brief description of the branch.
    description: ?[]const u8,

    /// The fully qualified name of the branch. For example, the fully qualified
    /// name of a
    /// branch might be `Vehicle.Body.Engine`.
    fully_qualified_name: []const u8,

    pub const json_field_names = .{
        .comment = "comment",
        .deprecation_message = "deprecationMessage",
        .description = "description",
        .fully_qualified_name = "fullyQualifiedName",
    };
};
