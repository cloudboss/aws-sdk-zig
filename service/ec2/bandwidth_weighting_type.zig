const std = @import("std");

pub const BandwidthWeightingType = enum {
    default,
    vpc_1,
    ebs_1,

    pub const json_field_names = .{
        .default = "default",
        .vpc_1 = "vpc-1",
        .ebs_1 = "ebs-1",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .default => "default",
            .vpc_1 => "vpc-1",
            .ebs_1 => "ebs-1",
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
