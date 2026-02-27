const Metadata = @import("metadata.zig").Metadata;
const RawResponse = @import("raw_response.zig").RawResponse;

/// Invocation output from a routing classifier model.
pub const RoutingClassifierModelInvocationOutput = struct {
    /// The invocation's metadata.
    metadata: ?Metadata,

    /// The invocation's raw response.
    raw_response: ?RawResponse,

    /// The invocation's trace ID.
    trace_id: ?[]const u8,

    pub const json_field_names = .{
        .metadata = "metadata",
        .raw_response = "rawResponse",
        .trace_id = "traceId",
    };
};
