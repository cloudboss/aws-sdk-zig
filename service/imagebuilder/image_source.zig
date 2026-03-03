const std = @import("std");

pub const ImageSource = enum {
    amazon_managed,
    aws_marketplace,
    imported,
    custom,

    pub const json_field_names = .{
        .amazon_managed = "AMAZON_MANAGED",
        .aws_marketplace = "AWS_MARKETPLACE",
        .imported = "IMPORTED",
        .custom = "CUSTOM",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .amazon_managed => "AMAZON_MANAGED",
            .aws_marketplace => "AWS_MARKETPLACE",
            .imported => "IMPORTED",
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
