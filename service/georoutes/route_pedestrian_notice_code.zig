const std = @import("std");

pub const RoutePedestrianNoticeCode = enum {
    accurate_polyline_unavailable,
    other,
    violated_avoid_dirt_road,
    violated_avoid_tunnel,
    violated_pedestrian_option,

    pub const json_field_names = .{
        .accurate_polyline_unavailable = "AccuratePolylineUnavailable",
        .other = "Other",
        .violated_avoid_dirt_road = "ViolatedAvoidDirtRoad",
        .violated_avoid_tunnel = "ViolatedAvoidTunnel",
        .violated_pedestrian_option = "ViolatedPedestrianOption",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .accurate_polyline_unavailable => "AccuratePolylineUnavailable",
            .other => "Other",
            .violated_avoid_dirt_road => "ViolatedAvoidDirtRoad",
            .violated_avoid_tunnel => "ViolatedAvoidTunnel",
            .violated_pedestrian_option => "ViolatedPedestrianOption",
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
