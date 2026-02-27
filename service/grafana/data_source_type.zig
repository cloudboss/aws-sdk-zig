pub const DataSourceType = enum {
    /// Amazon OpenSearch Service
    amazon_opensearch_service,
    /// CloudWatch Logs
    cloudwatch,
    /// Managed Prometheus
    prometheus,
    /// X-Ray
    xray,
    /// Timestream
    timestream,
    /// IoT SiteWise
    sitewise,
    /// Amazon Athena
    athena,
    /// Redshift
    redshift,
    /// IoT TwinMaker
    twinmaker,

    pub const json_field_names = .{
        .amazon_opensearch_service = "AMAZON_OPENSEARCH_SERVICE",
        .cloudwatch = "CLOUDWATCH",
        .prometheus = "PROMETHEUS",
        .xray = "XRAY",
        .timestream = "TIMESTREAM",
        .sitewise = "SITEWISE",
        .athena = "ATHENA",
        .redshift = "REDSHIFT",
        .twinmaker = "TWINMAKER",
    };
};
