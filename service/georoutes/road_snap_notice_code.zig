pub const RoadSnapNoticeCode = enum {
    trace_points_heading_ignored,
    trace_points_ignored,
    trace_points_moved_by_large_distance,
    trace_points_not_matched,
    trace_points_out_of_sequence,
    trace_points_speed_estimated,
    trace_points_speed_ignored,

    pub const json_field_names = .{
        .trace_points_heading_ignored = "TRACE_POINTS_HEADING_IGNORED",
        .trace_points_ignored = "TRACE_POINTS_IGNORED",
        .trace_points_moved_by_large_distance = "TRACE_POINTS_MOVED_BY_LARGE_DISTANCE",
        .trace_points_not_matched = "TRACE_POINTS_NOT_MATCHED",
        .trace_points_out_of_sequence = "TRACE_POINTS_OUT_OF_SEQUENCE",
        .trace_points_speed_estimated = "TRACE_POINTS_SPEED_ESTIMATED",
        .trace_points_speed_ignored = "TRACE_POINTS_SPEED_IGNORED",
    };
};
