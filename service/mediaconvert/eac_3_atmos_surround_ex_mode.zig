const std = @import("std");

/// Specify whether your input audio has an additional center rear surround
/// channel matrix encoded into your left and right surround channels.
pub const Eac3AtmosSurroundExMode = enum {
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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
