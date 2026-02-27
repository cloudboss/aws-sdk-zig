pub const SelfManageTargetDestination = enum {
    none_specified,
    amazon_elastic_cloud_compute,
    amazon_elastic_container_service,
    amazon_elastic_kubernetes_service,

    pub const json_field_names = .{
        .none_specified = "NONE_SPECIFIED",
        .amazon_elastic_cloud_compute = "AMAZON_ELASTIC_CLOUD_COMPUTE",
        .amazon_elastic_container_service = "AMAZON_ELASTIC_CONTAINER_SERVICE",
        .amazon_elastic_kubernetes_service = "AMAZON_ELASTIC_KUBERNETES_SERVICE",
    };
};
