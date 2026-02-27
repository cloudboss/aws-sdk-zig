const ComparisonOperator = @import("comparison_operator.zig").ComparisonOperator;
const FieldToMatch = @import("field_to_match.zig").FieldToMatch;
const TextTransformation = @import("text_transformation.zig").TextTransformation;

/// A rule statement that compares a number of bytes against the size of a
/// request component, using a comparison operator, such as greater than (>) or
/// less than (<). For example, you can use a size constraint statement to look
/// for query strings that are longer than 100 bytes.
///
/// If you configure WAF to inspect the request body, WAF inspects only the
/// number of bytes in the body up to the limit for the web ACL and protected
/// resource type. If you know that the request body for your web requests
/// should never exceed the inspection limit, you can use a size constraint
/// statement to block requests that have a larger request body size. For more
/// information about the inspection limits, see `Body` and `JsonBody` settings
/// for the `FieldToMatch` data type.
///
/// If you choose URI for the value of Part of the request to filter on, the
/// slash (/) in the URI counts as one character. For example, the URI
/// `/logo.jpg` is nine characters long.
pub const SizeConstraintStatement = struct {
    /// The operator to use to compare the request part to the size setting.
    comparison_operator: ComparisonOperator,

    /// The part of the web request that you want WAF to inspect.
    field_to_match: FieldToMatch,

    /// The size, in byte, to compare to the request part, after any
    /// transformations.
    size: i64 = 0,

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
        .comparison_operator = "ComparisonOperator",
        .field_to_match = "FieldToMatch",
        .size = "Size",
        .text_transformations = "TextTransformations",
    };
};
