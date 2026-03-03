const std = @import("std");

/// M2ts Nielsen Id3 Behavior
pub const M2tsNielsenId3Behavior = enum {
    no_passthrough,
    passthrough,

    pub const json_field_names = .{
        .no_passthrough = "NO_PASSTHROUGH",
        .passthrough = "PASSTHROUGH",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .no_passthrough => "NO_PASSTHROUGH",
            .passthrough => "PASSTHROUGH",
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
