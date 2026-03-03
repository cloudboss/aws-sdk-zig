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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
