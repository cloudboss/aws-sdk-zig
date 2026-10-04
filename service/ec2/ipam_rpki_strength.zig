const std = @import("std");

/// The RPKI enforcement strength for route protection.
pub const IpamRpkiStrength = enum {
    strict,
    permissive,

    pub const json_field_names = .{
        .strict = "strict",
        .permissive = "permissive",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .strict => "strict",
            .permissive => "permissive",
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
