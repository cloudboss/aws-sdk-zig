const std = @import("std");

pub const RoadSnapNoticeCode = enum {
    trace_points_heading_ignored,
    trace_points_ignored,
    trace_points_moved_by_large_distance,
    trace_points_not_matched,
    trace_points_out_of_sequence,
    trace_points_speed_estimated,
    trace_points_speed_ignored,

    pub const json_field_names = .{
        .trace_points_heading_ignored = "TracePointsHeadingIgnored",
        .trace_points_ignored = "TracePointsIgnored",
        .trace_points_moved_by_large_distance = "TracePointsMovedByLargeDistance",
        .trace_points_not_matched = "TracePointsNotMatched",
        .trace_points_out_of_sequence = "TracePointsOutOfSequence",
        .trace_points_speed_estimated = "TracePointsSpeedEstimated",
        .trace_points_speed_ignored = "TracePointsSpeedIgnored",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .trace_points_heading_ignored => "TracePointsHeadingIgnored",
            .trace_points_ignored => "TracePointsIgnored",
            .trace_points_moved_by_large_distance => "TracePointsMovedByLargeDistance",
            .trace_points_not_matched => "TracePointsNotMatched",
            .trace_points_out_of_sequence => "TracePointsOutOfSequence",
            .trace_points_speed_estimated => "TracePointsSpeedEstimated",
            .trace_points_speed_ignored => "TracePointsSpeedIgnored",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
