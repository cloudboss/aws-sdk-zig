const std = @import("std");

pub const ScopeResourceType = enum {
    apigw,
    cfd,
    eip,
    alb,
    clb,

    pub const json_field_names = .{
        .apigw = "AWS::ApiGateway::Stage",
        .cfd = "AWS::CloudFront::Distribution",
        .eip = "AWS::EC2::EIP",
        .alb = "AWS::ElasticLoadBalancingV2::LoadBalancer::application",
        .clb = "AWS::ElasticLoadBalancing::LoadBalancer",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .apigw => "AWS::ApiGateway::Stage",
            .cfd => "AWS::CloudFront::Distribution",
            .eip => "AWS::EC2::EIP",
            .alb => "AWS::ElasticLoadBalancingV2::LoadBalancer::application",
            .clb => "AWS::ElasticLoadBalancing::LoadBalancer",
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
