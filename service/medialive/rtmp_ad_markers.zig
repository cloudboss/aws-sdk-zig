const std = @import("std");

/// Rtmp Ad Markers
pub const RtmpAdMarkers = enum {
    on_cue_point_scte35,

    pub const json_field_names = .{
        .on_cue_point_scte35 = "ON_CUE_POINT_SCTE35",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .on_cue_point_scte35 => "ON_CUE_POINT_SCTE35",
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
