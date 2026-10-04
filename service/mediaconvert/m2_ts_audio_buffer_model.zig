const std = @import("std");

/// Selects between the DVB and ATSC buffer models for Dolby Digital audio.
pub const M2tsAudioBufferModel = enum {
    dvb,
    atsc,

    pub const json_field_names = .{
        .dvb = "DVB",
        .atsc = "ATSC",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .dvb => "DVB",
            .atsc => "ATSC",
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
