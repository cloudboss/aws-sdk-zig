const std = @import("std");

pub const Category = enum {
    registered,
    activated,
    third_party,
    aws_types,

    pub const json_field_names = .{
        .registered = "REGISTERED",
        .activated = "ACTIVATED",
        .third_party = "THIRD_PARTY",
        .aws_types = "AWS_TYPES",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .registered => "REGISTERED",
            .activated => "ACTIVATED",
            .third_party => "THIRD_PARTY",
            .aws_types => "AWS_TYPES",
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
