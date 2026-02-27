const FieldToMatch = @import("field_to_match.zig").FieldToMatch;
const TextTransformation = @import("text_transformation.zig").TextTransformation;

/// A rule statement used to search web request components for matches with
/// regular expressions. To use this, create a RegexPatternSet that specifies
/// the expressions that you want to detect, then use the ARN of that set in
/// this statement. A web request matches the pattern set rule statement if the
/// request component matches any of the patterns in the set. To create a regex
/// pattern set, see CreateRegexPatternSet.
///
/// Each regex pattern set rule statement references a regex pattern set. You
/// create and maintain the set independent of your rules. This allows you to
/// use the single set in multiple rules. When you update the referenced set,
/// WAF automatically updates all rules that reference it.
pub const RegexPatternSetReferenceStatement = struct {
    /// The Amazon Resource Name (ARN) of the RegexPatternSet that this
    /// statement references.
    arn: []const u8,

    /// The part of the web request that you want WAF to inspect.
    field_to_match: FieldToMatch,

    /// Text transformations eliminate some of the unusual formatting that attackers
    /// use in web requests in an effort to bypass detection. Text transformations
    /// are used in rule match statements, to transform the `FieldToMatch` request
    /// component before inspecting it, and they're used in rate-based rule
    /// statements, to transform request components before using them as custom
    /// aggregation keys. If you specify one or more transformations to apply, WAF
    /// performs all transformations on the specified content, starting from the
    /// lowest priority setting, and then uses the transformed component contents.
    text_transformations: []const TextTransformation,

    pub const json_field_names = .{
        .arn = "ARN",
        .field_to_match = "FieldToMatch",
        .text_transformations = "TextTransformations",
    };
};
