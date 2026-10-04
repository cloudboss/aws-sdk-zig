const std = @import("std");

/// Whether the SCTE-35 input should be the active input or a fixed input.
pub const Scte35InputMode = enum {
    fixed,
    follow_active,

    pub const json_field_names = .{
        .fixed = "FIXED",
        .follow_active = "FOLLOW_ACTIVE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .fixed => "FIXED",
            .follow_active => "FOLLOW_ACTIVE",
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
