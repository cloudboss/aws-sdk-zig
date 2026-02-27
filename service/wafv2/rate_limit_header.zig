const TextTransformation = @import("text_transformation.zig").TextTransformation;

/// Specifies a header as an aggregate key for a rate-based rule. Each distinct
/// value in the header contributes to the aggregation instance. If you use a
/// single
/// header as your custom key, then each value fully defines an aggregation
/// instance.
pub const RateLimitHeader = struct {
    /// The name of the header to use.
    name: []const u8,

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
        .name = "Name",
        .text_transformations = "TextTransformations",
    };
};
