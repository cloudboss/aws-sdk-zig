const ArchiveBooleanExpression = @import("archive_boolean_expression.zig").ArchiveBooleanExpression;
const ArchiveStringExpression = @import("archive_string_expression.zig").ArchiveStringExpression;

/// A filter condition used to include or exclude emails when exporting from or
/// searching an archive.
pub const ArchiveFilterCondition = union(enum) {
    /// A boolean expression to evaluate against email attributes.
    boolean_expression: ?ArchiveBooleanExpression,
    /// A string expression to evaluate against email attributes.
    string_expression: ?ArchiveStringExpression,

    pub const json_field_names = .{
        .boolean_expression = "BooleanExpression",
        .string_expression = "StringExpression",
    };
};
