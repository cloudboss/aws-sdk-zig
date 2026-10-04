const FieldToMatch = @import("field_to_match.zig").FieldToMatch;
const PreParseTextTransformation = @import("pre_parse_text_transformation.zig").PreParseTextTransformation;
const TextTransformation = @import("text_transformation.zig").TextTransformation;

/// A rule statement used to search web request components for a match against a
/// single regular expression.
pub const RegexMatchStatement = struct {
    /// The part of the web request that you want WAF to inspect.
    field_to_match: FieldToMatch,

    /// Pre-parse text transformations normalize the raw query string before WAF
    /// parses it into individual
    /// query arguments. They are applied before the standard text transformations.
    /// Pre-parse text transformations
    /// are only supported when `FieldToMatch` is `SingleQueryArgument` or
    /// `AllQueryArguments`. You can specify up to 10 pre-parse text transformations
    /// per rule statement.
    pre_parse_text_transformations: ?[]const PreParseTextTransformation = null,

    /// The string representing the regular expression. WAF enforces a quota on the
    /// maximum number of characters in a regex pattern. For the current limit, see
    /// [WAF
    /// quotas](https://docs.aws.amazon.com/waf/latest/developerguide/limits.html)
    /// in the *WAF Developer Guide*.
    regex_string: []const u8,

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
        .field_to_match = "FieldToMatch",
        .pre_parse_text_transformations = "PreParseTextTransformations",
        .regex_string = "RegexString",
        .text_transformations = "TextTransformations",
    };
};
