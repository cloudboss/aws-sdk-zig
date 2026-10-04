const std = @import("std");

/// Scte20 Convert608 To708
pub const Scte20Convert608To708 = enum {
    disabled,
    upconvert,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .upconvert = "UPCONVERT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .disabled => "DISABLED",
            .upconvert => "UPCONVERT",
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
