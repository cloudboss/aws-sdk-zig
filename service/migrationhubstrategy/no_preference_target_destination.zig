pub const NoPreferenceTargetDestination = enum {
    none_specified,
    aws_elastic_beanstalk,
    aws_fargate,
    amazon_elastic_cloud_compute,
    amazon_elastic_container_service,
    amazon_elastic_kubernetes_service,

    pub const json_field_names = .{
        .none_specified = "NONE_SPECIFIED",
        .aws_elastic_beanstalk = "AWS_ELASTIC_BEANSTALK",
        .aws_fargate = "AWS_FARGATE",
        .amazon_elastic_cloud_compute = "AMAZON_ELASTIC_CLOUD_COMPUTE",
        .amazon_elastic_container_service = "AMAZON_ELASTIC_CONTAINER_SERVICE",
        .amazon_elastic_kubernetes_service = "AMAZON_ELASTIC_KUBERNETES_SERVICE",
    };
};
