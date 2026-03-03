const std = @import("std");

pub const AWSServiceName = enum {
    aws,
    ec2,
    elasticache,
    elb,
    rds,
    route53,

    pub const json_field_names = .{
        .aws = "AWS",
        .ec2 = "EC2",
        .elasticache = "ELASTICACHE",
        .elb = "ELB",
        .rds = "RDS",
        .route53 = "ROUTE53",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aws => "AWS",
            .ec2 => "EC2",
            .elasticache => "ELASTICACHE",
            .elb => "ELB",
            .rds => "RDS",
            .route53 => "ROUTE53",
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
