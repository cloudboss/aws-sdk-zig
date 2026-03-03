const std = @import("std");

pub const EventSource = enum {
    cloud_trail,
    route53_resolver,
    vpc_flow,
    eks_audit,
    awswaf,

    pub const json_field_names = .{
        .cloud_trail = "CloudTrail",
        .route53_resolver = "Route53Resolver",
        .vpc_flow = "VPCFlow",
        .eks_audit = "EKSAudit",
        .awswaf = "AWSWAF",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cloud_trail => "CloudTrail",
            .route53_resolver => "Route53Resolver",
            .vpc_flow => "VPCFlow",
            .eks_audit => "EKSAudit",
            .awswaf => "AWSWAF",
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
