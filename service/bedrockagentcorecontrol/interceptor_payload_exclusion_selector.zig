const InterceptorPayloadExclusion = @import("interceptor_payload_exclusion.zig").InterceptorPayloadExclusion;

/// A selector that identifies a payload field to exclude from the interceptor
/// input.
pub const InterceptorPayloadExclusionSelector = union(enum) {
    /// The field to exclude from the interceptor input.
    field: ?InterceptorPayloadExclusion,

    pub const json_field_names = .{
        .field = "field",
    };
};
