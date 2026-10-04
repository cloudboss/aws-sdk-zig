const std = @import("std");

pub const ServiceNamespace = enum {
    autoscaling,
    ecs,
    ec2,
    rds,
    dynamodb,

    pub const json_field_names = .{
        .autoscaling = "autoscaling",
        .ecs = "ecs",
        .ec2 = "ec2",
        .rds = "rds",
        .dynamodb = "dynamodb",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .autoscaling => "autoscaling",
            .ecs => "ecs",
            .ec2 => "ec2",
            .rds => "rds",
            .dynamodb => "dynamodb",
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
