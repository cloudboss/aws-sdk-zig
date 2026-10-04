const InterceptorPayloadExclusionSelector = @import("interceptor_payload_exclusion_selector.zig").InterceptorPayloadExclusionSelector;

/// The filter that controls which fields of the request or response payload are
/// included in the input to the interceptor.
pub const InterceptorPayloadFilter = struct {
    /// The list of selectors that identify payload fields to exclude from the
    /// interceptor input.
    exclude: []const InterceptorPayloadExclusionSelector,

    pub const json_field_names = .{
        .exclude = "exclude",
    };
};
