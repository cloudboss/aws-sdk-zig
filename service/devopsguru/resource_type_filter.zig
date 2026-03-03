const std = @import("std");

pub const ResourceTypeFilter = enum {
    log_groups,
    cloudfront_distribution,
    dynamodb_table,
    ec2_nat_gateway,
    ecs_cluster,
    ecs_service,
    eks_cluster,
    elastic_beanstalk_environment,
    elastic_load_balancer_load_balancer,
    elastic_load_balancing_v2_load_balancer,
    elastic_load_balancing_v2_target_group,
    elasticache_cache_cluster,
    elasticsearch_domain,
    kinesis_stream,
    lambda_function,
    open_search_service_domain,
    rds_db_instance,
    rds_db_cluster,
    redshift_cluster,
    route53_hosted_zone,
    route53_health_check,
    s3_bucket,
    sagemaker_endpoint,
    sns_topic,
    sqs_queue,
    step_functions_activity,
    step_functions_state_machine,

    pub const json_field_names = .{
        .log_groups = "LOG_GROUPS",
        .cloudfront_distribution = "CLOUDFRONT_DISTRIBUTION",
        .dynamodb_table = "DYNAMODB_TABLE",
        .ec2_nat_gateway = "EC2_NAT_GATEWAY",
        .ecs_cluster = "ECS_CLUSTER",
        .ecs_service = "ECS_SERVICE",
        .eks_cluster = "EKS_CLUSTER",
        .elastic_beanstalk_environment = "ELASTIC_BEANSTALK_ENVIRONMENT",
        .elastic_load_balancer_load_balancer = "ELASTIC_LOAD_BALANCER_LOAD_BALANCER",
        .elastic_load_balancing_v2_load_balancer = "ELASTIC_LOAD_BALANCING_V2_LOAD_BALANCER",
        .elastic_load_balancing_v2_target_group = "ELASTIC_LOAD_BALANCING_V2_TARGET_GROUP",
        .elasticache_cache_cluster = "ELASTICACHE_CACHE_CLUSTER",
        .elasticsearch_domain = "ELASTICSEARCH_DOMAIN",
        .kinesis_stream = "KINESIS_STREAM",
        .lambda_function = "LAMBDA_FUNCTION",
        .open_search_service_domain = "OPEN_SEARCH_SERVICE_DOMAIN",
        .rds_db_instance = "RDS_DB_INSTANCE",
        .rds_db_cluster = "RDS_DB_CLUSTER",
        .redshift_cluster = "REDSHIFT_CLUSTER",
        .route53_hosted_zone = "ROUTE53_HOSTED_ZONE",
        .route53_health_check = "ROUTE53_HEALTH_CHECK",
        .s3_bucket = "S3_BUCKET",
        .sagemaker_endpoint = "SAGEMAKER_ENDPOINT",
        .sns_topic = "SNS_TOPIC",
        .sqs_queue = "SQS_QUEUE",
        .step_functions_activity = "STEP_FUNCTIONS_ACTIVITY",
        .step_functions_state_machine = "STEP_FUNCTIONS_STATE_MACHINE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .log_groups => "LOG_GROUPS",
            .cloudfront_distribution => "CLOUDFRONT_DISTRIBUTION",
            .dynamodb_table => "DYNAMODB_TABLE",
            .ec2_nat_gateway => "EC2_NAT_GATEWAY",
            .ecs_cluster => "ECS_CLUSTER",
            .ecs_service => "ECS_SERVICE",
            .eks_cluster => "EKS_CLUSTER",
            .elastic_beanstalk_environment => "ELASTIC_BEANSTALK_ENVIRONMENT",
            .elastic_load_balancer_load_balancer => "ELASTIC_LOAD_BALANCER_LOAD_BALANCER",
            .elastic_load_balancing_v2_load_balancer => "ELASTIC_LOAD_BALANCING_V2_LOAD_BALANCER",
            .elastic_load_balancing_v2_target_group => "ELASTIC_LOAD_BALANCING_V2_TARGET_GROUP",
            .elasticache_cache_cluster => "ELASTICACHE_CACHE_CLUSTER",
            .elasticsearch_domain => "ELASTICSEARCH_DOMAIN",
            .kinesis_stream => "KINESIS_STREAM",
            .lambda_function => "LAMBDA_FUNCTION",
            .open_search_service_domain => "OPEN_SEARCH_SERVICE_DOMAIN",
            .rds_db_instance => "RDS_DB_INSTANCE",
            .rds_db_cluster => "RDS_DB_CLUSTER",
            .redshift_cluster => "REDSHIFT_CLUSTER",
            .route53_hosted_zone => "ROUTE53_HOSTED_ZONE",
            .route53_health_check => "ROUTE53_HEALTH_CHECK",
            .s3_bucket => "S3_BUCKET",
            .sagemaker_endpoint => "SAGEMAKER_ENDPOINT",
            .sns_topic => "SNS_TOPIC",
            .sqs_queue => "SQS_QUEUE",
            .step_functions_activity => "STEP_FUNCTIONS_ACTIVITY",
            .step_functions_state_machine => "STEP_FUNCTIONS_STATE_MACHINE",
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
