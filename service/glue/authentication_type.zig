const std = @import("std");

pub const AuthenticationType = enum {
    basic,
    oauth2,
    custom,
    iam,

    pub const json_field_names = .{
        .basic = "BASIC",
        .oauth2 = "OAUTH2",
        .custom = "CUSTOM",
        .iam = "IAM",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .basic => "BASIC",
            .oauth2 => "OAUTH2",
            .custom => "CUSTOM",
            .iam => "IAM",
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
