const std = @import("std");

pub const S3GranteeTypeIdentifier = enum {
    canonical,
    email_address,
    group,

    pub const json_field_names = .{
        .canonical = "id",
        .email_address = "emailAddress",
        .group = "uri",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .canonical => "id",
            .email_address => "emailAddress",
            .group => "uri",
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
