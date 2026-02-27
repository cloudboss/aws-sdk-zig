/// TracePoints snapped onto the road network.
pub const RoadSnapSnappedTracePoint = struct {
    /// Confidence value for the correctness of this point match.
    confidence: f64,

    /// Position of the TracePoint provided within the request, at the same index.
    original_position: []const f64,

    /// Snapped position of the TracePoint provided within the request, at the same
    /// index.
    snapped_position: []const f64,

    pub const json_field_names = .{
        .confidence = "Confidence",
        .original_position = "OriginalPosition",
        .snapped_position = "SnappedPosition",
    };
};
