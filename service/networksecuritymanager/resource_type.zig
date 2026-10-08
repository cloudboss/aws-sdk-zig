const std = @import("std");

pub const ResourceType = enum {
    apigw,
    cfd,
    eip,
    alb,
    clb,
    waf_v2_webacl,
    shield_protection,
    shieldregional_protection,

    pub const json_field_names = .{
        .apigw = "AWS::ApiGateway::Stage",
        .cfd = "AWS::CloudFront::Distribution",
        .eip = "AWS::EC2::EIP",
        .alb = "AWS::ElasticLoadBalancingV2::LoadBalancer::application",
        .clb = "AWS::ElasticLoadBalancing::LoadBalancer",
        .waf_v2_webacl = "AWS::WAFv2::WebACL",
        .shield_protection = "AWS::Shield::Protection",
        .shieldregional_protection = "AWS::ShieldRegional::Protection",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .apigw => "AWS::ApiGateway::Stage",
            .cfd => "AWS::CloudFront::Distribution",
            .eip => "AWS::EC2::EIP",
            .alb => "AWS::ElasticLoadBalancingV2::LoadBalancer::application",
            .clb => "AWS::ElasticLoadBalancing::LoadBalancer",
            .waf_v2_webacl => "AWS::WAFv2::WebACL",
            .shield_protection => "AWS::Shield::Protection",
            .shieldregional_protection => "AWS::ShieldRegional::Protection",
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
