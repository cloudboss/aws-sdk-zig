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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
