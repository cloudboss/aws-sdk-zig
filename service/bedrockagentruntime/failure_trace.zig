const Metadata = @import("metadata.zig").Metadata;

/// Contains information about the failure of the interaction.
pub const FailureTrace = struct {
    /// The failure code for the trace.
    failure_code: ?i32,

    /// The reason the interaction failed.
    failure_reason: ?[]const u8,

    /// Information about the failure that occurred.
    metadata: ?Metadata,

    /// The unique identifier of the trace.
    trace_id: ?[]const u8,

    pub const json_field_names = .{
        .failure_code = "failureCode",
        .failure_reason = "failureReason",
        .metadata = "metadata",
        .trace_id = "traceId",
    };
};
