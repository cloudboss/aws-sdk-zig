const std = @import("std");

pub const ResourceType = enum {
    aws_ec2_instance,
    aws_ec2_vpc,
    aws_lamdba_function,
    aws_cloudtrail,
    aws_eks_cluster,
    aws_waf_v2_web_acl,
    aws_elb_loadbalancer,
    aws_route53_resolver_resolver_endpoint,
    aws_bedrock_agentcore_runtime,
    aws_bedrock_agentcore_browser,
    aws_bedrock_agentcore_code_interpreter,

    pub const json_field_names = .{
        .aws_ec2_instance = "AWS::EC2::Instance",
        .aws_ec2_vpc = "AWS::EC2::VPC",
        .aws_lamdba_function = "AWS::Lambda::Function",
        .aws_cloudtrail = "AWS::CloudTrail",
        .aws_eks_cluster = "AWS::EKS::Cluster",
        .aws_waf_v2_web_acl = "AWS::WAFv2::WebACL",
        .aws_elb_loadbalancer = "AWS::ElasticLoadBalancingV2::LoadBalancer",
        .aws_route53_resolver_resolver_endpoint = "AWS::Route53Resolver::ResolverEndpoint",
        .aws_bedrock_agentcore_runtime = "AWS::BedrockAgentCore::Runtime",
        .aws_bedrock_agentcore_browser = "AWS::BedrockAgentCore::Browser",
        .aws_bedrock_agentcore_code_interpreter = "AWS::BedrockAgentCore::CodeInterpreter",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aws_ec2_instance => "AWS::EC2::Instance",
            .aws_ec2_vpc => "AWS::EC2::VPC",
            .aws_lamdba_function => "AWS::Lambda::Function",
            .aws_cloudtrail => "AWS::CloudTrail",
            .aws_eks_cluster => "AWS::EKS::Cluster",
            .aws_waf_v2_web_acl => "AWS::WAFv2::WebACL",
            .aws_elb_loadbalancer => "AWS::ElasticLoadBalancingV2::LoadBalancer",
            .aws_route53_resolver_resolver_endpoint => "AWS::Route53Resolver::ResolverEndpoint",
            .aws_bedrock_agentcore_runtime => "AWS::BedrockAgentCore::Runtime",
            .aws_bedrock_agentcore_browser => "AWS::BedrockAgentCore::Browser",
            .aws_bedrock_agentcore_code_interpreter => "AWS::BedrockAgentCore::CodeInterpreter",
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
