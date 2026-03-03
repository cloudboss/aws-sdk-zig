const std = @import("std");

pub const CpuVendorArchitecture = enum {
    aws_arm64,
    current,

    pub const json_field_names = .{
        .aws_arm64 = "AWS_ARM64",
        .current = "CURRENT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aws_arm64 => "AWS_ARM64",
            .current => "CURRENT",
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
