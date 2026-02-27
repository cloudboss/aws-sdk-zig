const FieldToMatch = @import("field_to_match.zig").FieldToMatch;
const SensitivityLevel = @import("sensitivity_level.zig").SensitivityLevel;
const TextTransformation = @import("text_transformation.zig").TextTransformation;

/// A rule statement that inspects for malicious SQL code. Attackers insert
/// malicious SQL code into web requests to do things like modify your database
/// or extract data from it.
pub const SqliMatchStatement = struct {
    /// The part of the web request that you want WAF to inspect.
    field_to_match: FieldToMatch,

    /// The sensitivity that you want WAF to use to inspect for SQL injection
    /// attacks.
    ///
    /// `HIGH` detects more attacks, but might generate more false positives,
    /// especially if your web requests frequently contain unusual strings.
    /// For information about identifying and mitigating false positives, see
    /// [Testing and
    /// tuning](https://docs.aws.amazon.com/waf/latest/developerguide/web-acl-testing.html) in the
    /// *WAF Developer Guide*.
    ///
    /// `LOW` is generally a better choice for resources that already have other
    /// protections against SQL injection attacks or that have a low tolerance for
    /// false positives.
    ///
    /// Default: `LOW`
    sensitivity_level: ?SensitivityLevel,

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
        .sensitivity_level = "SensitivityLevel",
        .text_transformations = "TextTransformations",
    };
};
