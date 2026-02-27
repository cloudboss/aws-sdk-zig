const TextTransformation = @import("text_transformation.zig").TextTransformation;

/// Specifies the request's query string as an aggregate key for a rate-based
/// rule. Each distinct string contributes to the aggregation instance. If you
/// use just the
/// query string as your custom key, then each string fully defines an
/// aggregation instance.
pub const RateLimitQueryString = struct {
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
        .text_transformations = "TextTransformations",
    };
};
