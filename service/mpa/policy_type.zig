const std = @import("std");

pub const PolicyType = enum {
    aws_managed,
    aws_ram,

    pub const json_field_names = .{
        .aws_managed = "AWS_MANAGED",
        .aws_ram = "AWS_RAM",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aws_managed => "AWS_MANAGED",
            .aws_ram => "AWS_RAM",
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
