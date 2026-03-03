const Metadata = @import("metadata.zig").Metadata;
const RawResponse = @import("raw_response.zig").RawResponse;

/// Invocation output from a routing classifier model.
pub const RoutingClassifierModelInvocationOutput = struct {
    /// The invocation's metadata.
    metadata: ?Metadata = null,

    /// The invocation's raw response.
    raw_response: ?RawResponse = null,

    /// The invocation's trace ID.
    trace_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .metadata = "metadata",
        .raw_response = "rawResponse",
        .trace_id = "traceId",
    };
};
