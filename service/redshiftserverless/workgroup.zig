const ConfigParameter = @import("config_parameter.zig").ConfigParameter;
const Endpoint = @import("endpoint.zig").Endpoint;
const PerformanceTarget = @import("performance_target.zig").PerformanceTarget;
const WorkgroupStatus = @import("workgroup_status.zig").WorkgroupStatus;

/// The collection of computing resources from which an endpoint is created.
pub const Workgroup = struct {
    /// The base data warehouse capacity of the workgroup in Redshift Processing
    /// Units (RPUs).
    base_capacity: ?i32 = null,

    /// An array of parameters to set for advanced control over a database. The
    /// options are `auto_mv`, `datestyle`, `enable_case_sensitive_identifier`,
    /// `enable_user_activity_logging`, `query_group`, `search_path`, `require_ssl`,
    /// `use_fips_ssl`, and either `wlm_json_configuration` or query monitoring
    /// metrics that let you define performance boundaries. You can either specify
    /// individual query monitoring metrics (such as `max_scan_row_count`,
    /// `max_query_execution_time`) or use `wlm_json_configuration` to define query
    /// queues with rules, but not both. If you're using `wlm_json_configuration`,
    /// the maximum size of `parameterValue` is 8000 characters. For more
    /// information about query monitoring rules and available metrics, see [ Query
    /// monitoring metrics for Amazon Redshift
    /// Serverless](https://docs.aws.amazon.com/redshift/latest/dg/cm-c-wlm-query-monitoring-rules.html#cm-c-wlm-query-monitoring-metrics-serverless).
    config_parameters: ?[]const ConfigParameter = null,

    /// The creation date of the workgroup.
    creation_date: ?i64 = null,

    /// A list of VPCs. Each entry is the unique identifier of a virtual private
    /// cloud with access to Amazon Redshift Serverless. If all of the VPCs for the
    /// grantee are allowed, it shows an asterisk.
    cross_account_vpcs: ?[]const []const u8 = null,

    /// The custom domain name’s certificate Amazon resource name (ARN).
    custom_domain_certificate_arn: ?[]const u8 = null,

    /// The expiration time for the certificate.
    custom_domain_certificate_expiry_time: ?i64 = null,

    /// The custom domain name associated with the workgroup.
    custom_domain_name: ?[]const u8 = null,

    /// The endpoint that is created from the workgroup.
    endpoint: ?Endpoint = null,

    /// The value that specifies whether to enable enhanced virtual private cloud
    /// (VPC) routing, which forces Amazon Redshift Serverless to route traffic
    /// through your VPC.
    enhanced_vpc_routing: ?bool = null,

    /// A boolean value that, if `true`, indicates that the workgroup allocates
    /// additional compute resources to run automatic optimization operations.
    ///
    /// Default: false
    extra_compute_for_automatic_optimization: ?bool = null,

    /// The IP address type that the workgroup supports. Possible values are `ipv4`
    /// and `dualstack`.
    ip_address_type: ?[]const u8 = null,

    /// The maximum data-warehouse capacity Amazon Redshift Serverless uses to serve
    /// queries. The max capacity is specified in RPUs.
    max_capacity: ?i32 = null,

    /// The namespace the workgroup is associated with.
    namespace_name: ?[]const u8 = null,

    /// The patch version of your Amazon Redshift Serverless workgroup. For more
    /// information about patch versions, see [Cluster versions for Amazon
    /// Redshift](https://docs.aws.amazon.com/redshift/latest/mgmt/cluster-versions.html).
    patch_version: ?[]const u8 = null,

    /// The name for the track that you want to assign to the workgroup. When the
    /// track changes, the workgroup is switched to the latest workgroup release
    /// available for the track. At this point, the track name is applied.
    pending_track_name: ?[]const u8 = null,

    /// The custom port to use when connecting to a workgroup. Valid port ranges are
    /// 5431-5455 and 8191-8215. The default is 5439.
    port: ?i32 = null,

    /// An object that represents the price performance target settings for the
    /// workgroup.
    price_performance_target: ?PerformanceTarget = null,

    /// A value that specifies whether the workgroup can be accessible from a public
    /// network.
    publicly_accessible: ?bool = null,

    /// An array of security group IDs to associate with the workgroup.
    security_group_ids: ?[]const []const u8 = null,

    /// The status of the workgroup.
    status: ?WorkgroupStatus = null,

    /// An array of subnet IDs the workgroup is associated with.
    subnet_ids: ?[]const []const u8 = null,

    /// The name of the track for the workgroup.
    track_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) that links to the workgroup.
    workgroup_arn: ?[]const u8 = null,

    /// The unique identifier of the workgroup.
    workgroup_id: ?[]const u8 = null,

    /// The name of the workgroup.
    workgroup_name: ?[]const u8 = null,

    /// The Amazon Redshift Serverless version of your workgroup. For more
    /// information about Amazon Redshift Serverless versions, see[Cluster versions
    /// for Amazon
    /// Redshift](https://docs.aws.amazon.com/redshift/latest/mgmt/cluster-versions.html).
    workgroup_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .base_capacity = "baseCapacity",
        .config_parameters = "configParameters",
        .creation_date = "creationDate",
        .cross_account_vpcs = "crossAccountVpcs",
        .custom_domain_certificate_arn = "customDomainCertificateArn",
        .custom_domain_certificate_expiry_time = "customDomainCertificateExpiryTime",
        .custom_domain_name = "customDomainName",
        .endpoint = "endpoint",
        .enhanced_vpc_routing = "enhancedVpcRouting",
        .extra_compute_for_automatic_optimization = "extraComputeForAutomaticOptimization",
        .ip_address_type = "ipAddressType",
        .max_capacity = "maxCapacity",
        .namespace_name = "namespaceName",
        .patch_version = "patchVersion",
        .pending_track_name = "pendingTrackName",
        .port = "port",
        .price_performance_target = "pricePerformanceTarget",
        .publicly_accessible = "publiclyAccessible",
        .security_group_ids = "securityGroupIds",
        .status = "status",
        .subnet_ids = "subnetIds",
        .track_name = "trackName",
        .workgroup_arn = "workgroupArn",
        .workgroup_id = "workgroupId",
        .workgroup_name = "workgroupName",
        .workgroup_version = "workgroupVersion",
    };
};
