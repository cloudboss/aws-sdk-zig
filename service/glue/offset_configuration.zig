const ExtractedParameter = @import("extracted_parameter.zig").ExtractedParameter;

/// Offset-based pagination configuration that defines how to handle pagination
/// using numeric offsets and limits.
pub const OffsetConfiguration = struct {
    /// The parameter name used to specify the maximum number of results to return
    /// per page.
    limit_parameter: ExtractedParameter,

    /// The parameter name used to specify the starting position or offset for
    /// retrieving results.
    offset_parameter: ExtractedParameter,

    pub const json_field_names = .{
        .limit_parameter = "LimitParameter",
        .offset_parameter = "OffsetParameter",
    };
};
