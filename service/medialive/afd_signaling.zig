const std = @import("std");

/// Afd Signaling
pub const AfdSignaling = enum {
    auto,
    fixed,
    none,

    pub const json_field_names = .{
        .auto = "AUTO",
        .fixed = "FIXED",
        .none = "NONE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .auto => "AUTO",
            .fixed => "FIXED",
            .none => "NONE",
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
