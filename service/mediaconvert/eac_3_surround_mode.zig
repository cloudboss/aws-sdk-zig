const std = @import("std");

/// When encoding 2/0 audio, sets whether Dolby Surround is matrix encoded into
/// the two channels.
pub const Eac3SurroundMode = enum {
    not_indicated,
    enabled,
    disabled,

    pub const json_field_names = .{
        .not_indicated = "NOT_INDICATED",
        .enabled = "ENABLED",
        .disabled = "DISABLED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .not_indicated => "NOT_INDICATED",
            .enabled => "ENABLED",
            .disabled => "DISABLED",
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
