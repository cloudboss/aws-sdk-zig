const std = @import("std");

pub const EffectivePermission = enum {
    public,
    not_public,
    unknown,

    pub const json_field_names = .{
        .public = "PUBLIC",
        .not_public = "NOT_PUBLIC",
        .unknown = "UNKNOWN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .public => "PUBLIC",
            .not_public => "NOT_PUBLIC",
            .unknown => "UNKNOWN",
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
