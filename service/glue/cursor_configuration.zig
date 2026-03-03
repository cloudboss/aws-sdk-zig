const ExtractedParameter = @import("extracted_parameter.zig").ExtractedParameter;

/// Cursor-based pagination configuration that defines how to handle pagination
/// using cursor tokens or next page identifiers.
pub const CursorConfiguration = struct {
    /// The parameter name used to specify the maximum number of results to return
    /// per page.
    limit_parameter: ?ExtractedParameter = null,

    /// The parameter name or JSON path that contains the cursor or token for
    /// retrieving the next page of results.
    next_page: ExtractedParameter,

    pub const json_field_names = .{
        .limit_parameter = "LimitParameter",
        .next_page = "NextPage",
    };
};
