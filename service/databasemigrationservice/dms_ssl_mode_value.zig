const std = @import("std");

pub const DmsSslModeValue = enum {
    none,
    require,
    verify_ca,
    verify_full,

    pub const json_field_names = .{
        .none = "none",
        .require = "require",
        .verify_ca = "verify-ca",
        .verify_full = "verify-full",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "none",
            .require => "require",
            .verify_ca => "verify-ca",
            .verify_full => "verify-full",
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
