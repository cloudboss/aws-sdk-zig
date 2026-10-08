const PreParseTextTransformationType = @import("pre_parse_text_transformation_type.zig").PreParseTextTransformationType;

/// A pre-parse text transformation that normalizes the raw query string before
/// WAF parses
/// it into individual query arguments. Pre-parse text transformations are only
/// supported when
/// `FieldToMatch` is `SingleQueryArgument` or `AllQueryArguments`.
pub const PreParseTextTransformation = struct {
    /// Sets the relative processing order for the pre-parse text transformations
    /// that you define.
    /// WAF processes all transformations, from lowest priority value to highest,
    /// before inspecting the transformed content.
    priority: i32 = 0,

    /// The type of pre-parse text transformation to apply to the raw query string.
    type: PreParseTextTransformationType,

    pub const json_field_names = .{
        .priority = "Priority",
        .type = "Type",
    };
};
