const std = @import("std");

pub const RouterOutputProtocol = enum {
    rtp,
    rist,
    srt_caller,
    srt_listener,
    rtmp_push,

    pub const json_field_names = .{
        .rtp = "RTP",
        .rist = "RIST",
        .srt_caller = "SRT_CALLER",
        .srt_listener = "SRT_LISTENER",
        .rtmp_push = "RTMP_PUSH",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .rtp => "RTP",
            .rist => "RIST",
            .srt_caller => "SRT_CALLER",
            .srt_listener => "SRT_LISTENER",
            .rtmp_push => "RTMP_PUSH",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
