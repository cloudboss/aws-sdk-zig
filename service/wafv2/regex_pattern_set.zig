const Regex = @import("regex.zig").Regex;

/// Contains one or more regular expressions.
///
/// WAF assigns an ARN to each `RegexPatternSet` that you create. To use a
/// set in a rule, you provide the ARN to the Rule statement
/// RegexPatternSetReferenceStatement.
pub const RegexPatternSet = struct {
    /// The Amazon Resource Name (ARN) of the entity.
    arn: ?[]const u8,

    /// A description of the set that helps with identification.
    description: ?[]const u8,

    /// A unique identifier for the set. This ID is returned in the responses to
    /// create and list commands. You provide it to operations like update and
    /// delete.
    id: ?[]const u8,

    /// The name of the set. You cannot change the name after you create the set.
    name: ?[]const u8,

    /// The regular expression patterns in the set.
    regular_expression_list: ?[]const Regex,

    pub const json_field_names = .{
        .arn = "ARN",
        .description = "Description",
        .id = "Id",
        .name = "Name",
        .regular_expression_list = "RegularExpressionList",
    };
};
