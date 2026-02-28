const TextTransformationType = @import("text_transformation_type.zig").TextTransformationType;

/// Text transformations eliminate some of the unusual formatting that attackers
/// use in web
/// requests in an effort to bypass detection.
pub const TextTransformation = struct {
    /// Sets the relative processing order for multiple transformations.
    /// WAF processes all transformations, from lowest priority to highest,
    /// before inspecting the transformed content. The priorities don't need to be
    /// consecutive, but
    /// they must all be different.
    priority: i32 = 0,

    /// For detailed descriptions of each of the transformation types, see [Text
    /// transformations](https://docs.aws.amazon.com/waf/latest/developerguide/waf-rule-statement-transformation.html)
    /// in the *WAF Developer Guide*.
    @"type": TextTransformationType,

    pub const json_field_names = .{
        .priority = "Priority",
        .@"type" = "Type",
    };
};
