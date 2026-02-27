const RoadSnapNoticeCode = @import("road_snap_notice_code.zig").RoadSnapNoticeCode;

/// Notices provide information around factors that may have influenced snapping
/// in a manner atypical to the standard use cases.
pub const RoadSnapNotice = struct {
    /// Code corresponding to the issue.
    code: RoadSnapNoticeCode,

    /// The notice title.
    title: []const u8,

    /// TracePoint indices for which the provided notice code corresponds to.
    trace_point_indexes: []const i32,

    pub const json_field_names = .{
        .code = "Code",
        .title = "Title",
        .trace_point_indexes = "TracePointIndexes",
    };
};
