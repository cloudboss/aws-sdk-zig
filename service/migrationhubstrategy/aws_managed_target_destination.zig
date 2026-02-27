pub const AwsManagedTargetDestination = enum {
    none_specified,
    aws_elastic_beanstalk,
    aws_fargate,

    pub const json_field_names = .{
        .none_specified = "NONE_SPECIFIED",
        .aws_elastic_beanstalk = "AWS_ELASTIC_BEANSTALK",
        .aws_fargate = "AWS_FARGATE",
    };
};
