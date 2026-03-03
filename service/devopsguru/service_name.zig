const std = @import("std");

pub const ServiceName = enum {
    api_gateway,
    application_elb,
    auto_scaling_group,
    cloud_front,
    dynamo_db,
    ec2,
    ecs,
    eks,
    elastic_beanstalk,
    elasti_cache,
    elb,
    es,
    kinesis,
    lambda,
    nat_gateway,
    network_elb,
    rds,
    redshift,
    route_53,
    s3,
    sage_maker,
    sns,
    sqs,
    step_functions,
    swf,

    pub const json_field_names = .{
        .api_gateway = "API_GATEWAY",
        .application_elb = "APPLICATION_ELB",
        .auto_scaling_group = "AUTO_SCALING_GROUP",
        .cloud_front = "CLOUD_FRONT",
        .dynamo_db = "DYNAMO_DB",
        .ec2 = "EC2",
        .ecs = "ECS",
        .eks = "EKS",
        .elastic_beanstalk = "ELASTIC_BEANSTALK",
        .elasti_cache = "ELASTI_CACHE",
        .elb = "ELB",
        .es = "ES",
        .kinesis = "KINESIS",
        .lambda = "LAMBDA",
        .nat_gateway = "NAT_GATEWAY",
        .network_elb = "NETWORK_ELB",
        .rds = "RDS",
        .redshift = "REDSHIFT",
        .route_53 = "ROUTE_53",
        .s3 = "S3",
        .sage_maker = "SAGE_MAKER",
        .sns = "SNS",
        .sqs = "SQS",
        .step_functions = "STEP_FUNCTIONS",
        .swf = "SWF",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .api_gateway => "API_GATEWAY",
            .application_elb => "APPLICATION_ELB",
            .auto_scaling_group => "AUTO_SCALING_GROUP",
            .cloud_front => "CLOUD_FRONT",
            .dynamo_db => "DYNAMO_DB",
            .ec2 => "EC2",
            .ecs => "ECS",
            .eks => "EKS",
            .elastic_beanstalk => "ELASTIC_BEANSTALK",
            .elasti_cache => "ELASTI_CACHE",
            .elb => "ELB",
            .es => "ES",
            .kinesis => "KINESIS",
            .lambda => "LAMBDA",
            .nat_gateway => "NAT_GATEWAY",
            .network_elb => "NETWORK_ELB",
            .rds => "RDS",
            .redshift => "REDSHIFT",
            .route_53 => "ROUTE_53",
            .s3 => "S3",
            .sage_maker => "SAGE_MAKER",
            .sns => "SNS",
            .sqs => "SQS",
            .step_functions => "STEP_FUNCTIONS",
            .swf => "SWF",
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
