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
        .aws_ec2_instance = "AWS_EC2_INSTANCE",
        .aws_ec2_vpc = "AWS_EC2_VPC",
        .aws_lamdba_function = "AWS_LAMDBA_FUNCTION",
        .aws_cloudtrail = "AWS_CLOUDTRAIL",
        .aws_eks_cluster = "AWS_EKS_CLUSTER",
        .aws_waf_v2_web_acl = "AWS_WAF_V2_WEB_ACL",
        .aws_elb_loadbalancer = "AWS_ELB_LOADBALANCER",
        .aws_route53_resolver_resolver_endpoint = "AWS_ROUTE53_RESOLVER_RESOLVER_ENDPOINT",
        .aws_bedrock_agentcore_runtime = "AWS_BEDROCK_AGENTCORE_RUNTIME",
        .aws_bedrock_agentcore_browser = "AWS_BEDROCK_AGENTCORE_BROWSER",
        .aws_bedrock_agentcore_code_interpreter = "AWS_BEDROCK_AGENTCORE_CODE_INTERPRETER",
    };
};
