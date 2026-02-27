const TraceLocationType = @import("trace_location_type.zig").TraceLocationType;

/// Information about where trace data is stored for debugging and monitoring.
pub const TraceLocation = struct {
    /// The specific location where the trace data is stored.
    location: []const u8,

    /// The type of storage location for the trace data.
    location_type: TraceLocationType,

    pub const json_field_names = .{
        .location = "location",
        .location_type = "locationType",
    };
};
