const std = @import("std");

/// If set to LOG, log each output's audio track loudness to a CSV file.
pub const AudioNormalizationLoudnessLogging = enum {
    log,
    dont_log,

    pub const json_field_names = .{
        .log = "LOG",
        .dont_log = "DONT_LOG",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .log => "LOG",
            .dont_log => "DONT_LOG",
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
