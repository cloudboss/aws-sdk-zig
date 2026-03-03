const std = @import("std");

pub const CRType = enum {
    ec2,
    spot,
    fargate,
    fargate_spot,

    pub const json_field_names = .{
        .ec2 = "EC2",
        .spot = "SPOT",
        .fargate = "FARGATE",
        .fargate_spot = "FARGATE_SPOT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ec2 => "EC2",
            .spot => "SPOT",
            .fargate => "FARGATE",
            .fargate_spot => "FARGATE_SPOT",
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
