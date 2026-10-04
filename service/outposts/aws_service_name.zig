const std = @import("std");

pub const AWSServiceName = enum {
    aws,
    ec2,
    eks,
    elasticache,
    elb,
    rds,
    route53,

    pub const json_field_names = .{
        .aws = "AWS",
        .ec2 = "EC2",
        .eks = "EKS",
        .elasticache = "ELASTICACHE",
        .elb = "ELB",
        .rds = "RDS",
        .route53 = "ROUTE53",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aws => "AWS",
            .ec2 => "EC2",
            .eks => "EKS",
            .elasticache => "ELASTICACHE",
            .elb => "ELB",
            .rds => "RDS",
            .route53 => "ROUTE53",
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
