const BackendConnectionErrors = @import("backend_connection_errors.zig").BackendConnectionErrors;

pub const TelemetryRecord = struct {
    backend_connection_errors: ?BackendConnectionErrors = null,

    segments_received_count: ?i32 = null,

    segments_rejected_count: ?i32 = null,

    segments_sent_count: ?i32 = null,

    segments_spillover_count: ?i32 = null,

    timestamp: i64,

    pub const json_field_names = .{
        .backend_connection_errors = "BackendConnectionErrors",
        .segments_received_count = "SegmentsReceivedCount",
        .segments_rejected_count = "SegmentsRejectedCount",
        .segments_sent_count = "SegmentsSentCount",
        .segments_spillover_count = "SegmentsSpilloverCount",
        .timestamp = "Timestamp",
    };
};
