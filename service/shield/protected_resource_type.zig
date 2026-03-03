const std = @import("std");

pub const ProtectedResourceType = enum {
    cloudfront_distribution,
    route_53_hosted_zone,
    elastic_ip_allocation,
    classic_load_balancer,
    application_load_balancer,
    global_accelerator,

    pub const json_field_names = .{
        .cloudfront_distribution = "CLOUDFRONT_DISTRIBUTION",
        .route_53_hosted_zone = "ROUTE_53_HOSTED_ZONE",
        .elastic_ip_allocation = "ELASTIC_IP_ALLOCATION",
        .classic_load_balancer = "CLASSIC_LOAD_BALANCER",
        .application_load_balancer = "APPLICATION_LOAD_BALANCER",
        .global_accelerator = "GLOBAL_ACCELERATOR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cloudfront_distribution => "CLOUDFRONT_DISTRIBUTION",
            .route_53_hosted_zone => "ROUTE_53_HOSTED_ZONE",
            .elastic_ip_allocation => "ELASTIC_IP_ALLOCATION",
            .classic_load_balancer => "CLASSIC_LOAD_BALANCER",
            .application_load_balancer => "APPLICATION_LOAD_BALANCER",
            .global_accelerator => "GLOBAL_ACCELERATOR",
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
