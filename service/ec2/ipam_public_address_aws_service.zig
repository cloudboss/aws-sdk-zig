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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
