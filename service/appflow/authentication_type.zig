const std = @import("std");

pub const AuthenticationType = enum {
    oauth2,
    apikey,
    basic,
    custom,

    pub const json_field_names = .{
        .oauth2 = "OAUTH2",
        .apikey = "APIKEY",
        .basic = "BASIC",
        .custom = "CUSTOM",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .oauth2 => "OAUTH2",
            .apikey => "APIKEY",
            .basic => "BASIC",
            .custom => "CUSTOM",
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
