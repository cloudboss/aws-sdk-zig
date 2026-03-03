const std = @import("std");

pub const Auth = enum {
    plain_text,
    secret_arn,

    pub const json_field_names = .{
        .plain_text = "PLAIN_TEXT",
        .secret_arn = "SECRET_ARN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .plain_text => "PLAIN_TEXT",
            .secret_arn => "SECRET_ARN",
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
