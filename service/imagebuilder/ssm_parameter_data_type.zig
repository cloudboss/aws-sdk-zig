const std = @import("std");

pub const SsmParameterDataType = enum {
    text,
    aws_ec2_image,

    pub const json_field_names = .{
        .text = "text",
        .aws_ec2_image = "aws:ec2:image",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .text => "text",
            .aws_ec2_image => "aws:ec2:image",
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
