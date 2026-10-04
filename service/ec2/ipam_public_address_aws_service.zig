const std = @import("std");

pub const IpamPublicAddressAwsService = enum {
    nat_gateway,
    dms,
    redshift,
    ecs,
    rds,
    s2_s_vpn,
    ec2_lb,
    aga,
    cloudfront,
    other,

    pub const json_field_names = .{
        .nat_gateway = "nat-gateway",
        .dms = "database-migration-service",
        .redshift = "redshift",
        .ecs = "elastic-container-service",
        .rds = "relational-database-service",
        .s2_s_vpn = "site-to-site-vpn",
        .ec2_lb = "load-balancer",
        .aga = "global-accelerator",
        .cloudfront = "cloudfront",
        .other = "other",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .nat_gateway => "nat-gateway",
            .dms => "database-migration-service",
            .redshift => "redshift",
            .ecs => "elastic-container-service",
            .rds => "relational-database-service",
            .s2_s_vpn => "site-to-site-vpn",
            .ec2_lb => "load-balancer",
            .aga => "global-accelerator",
            .cloudfront => "cloudfront",
            .other => "other",
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
