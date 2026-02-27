const CustomerContentEncryptionConfiguration = @import("customer_content_encryption_configuration.zig").CustomerContentEncryptionConfiguration;
const EngineConfiguration = @import("engine_configuration.zig").EngineConfiguration;
const EngineVersion = @import("engine_version.zig").EngineVersion;
const IdentityCenterConfiguration = @import("identity_center_configuration.zig").IdentityCenterConfiguration;
const ManagedQueryResultsConfiguration = @import("managed_query_results_configuration.zig").ManagedQueryResultsConfiguration;
const MonitoringConfiguration = @import("monitoring_configuration.zig").MonitoringConfiguration;
const QueryResultsS3AccessGrantsConfiguration = @import("query_results_s3_access_grants_configuration.zig").QueryResultsS3AccessGrantsConfiguration;
const ResultConfiguration = @import("result_configuration.zig").ResultConfiguration;

/// The configuration of the workgroup, which includes the location in Amazon S3
/// where query and calculation results are stored, the encryption option, if
/// any, used for
/// query and calculation results, whether the Amazon CloudWatch Metrics are
/// enabled for
/// the workgroup and whether workgroup settings override query settings, and
/// the data usage
/// limits for the amount of data scanned per query or per workgroup. The
/// workgroup settings
/// override is specified in `EnforceWorkGroupConfiguration` (true/false) in the
/// `WorkGroupConfiguration`. See
/// WorkGroupConfiguration$EnforceWorkGroupConfiguration.
pub const WorkGroupConfiguration = struct {
    /// Specifies a user defined JSON string that is passed to the notebook engine.
    additional_configuration: ?[]const u8,

    /// The upper data usage limit (cutoff) for the amount of bytes a single query
    /// in a
    /// workgroup is allowed to scan.
    bytes_scanned_cutoff_per_query: ?i64,

    /// Specifies the KMS key that is used to encrypt the user's data stores in
    /// Athena. This setting does not apply to Athena SQL workgroups.
    customer_content_encryption_configuration: ?CustomerContentEncryptionConfiguration,

    /// Enforces a minimal level of encryption for the workgroup for query and
    /// calculation
    /// results that are written to Amazon S3. When enabled, workgroup users can set
    /// encryption only to the minimum level set by the administrator or higher when
    /// they submit
    /// queries.
    ///
    /// The `EnforceWorkGroupConfiguration` setting takes precedence over the
    /// `EnableMinimumEncryptionConfiguration` flag. This means that if
    /// `EnforceWorkGroupConfiguration` is true, the
    /// `EnableMinimumEncryptionConfiguration` flag is ignored, and the workgroup
    /// configuration for encryption is used.
    enable_minimum_encryption_configuration: ?bool,

    /// If set to "true", the settings for the workgroup override client-side
    /// settings. If set
    /// to "false", client-side settings are used. This property is not required for
    /// Apache
    /// Spark enabled workgroups. For more information, see [Workgroup Settings
    /// Override
    /// Client-Side
    /// Settings](https://docs.aws.amazon.com/athena/latest/ug/workgroups-settings-override.html).
    enforce_work_group_configuration: ?bool,

    engine_configuration: ?EngineConfiguration,

    /// The engine version that all queries running on the workgroup use. Queries on
    /// the
    /// `AmazonAthenaPreviewFunctionality` workgroup run on the preview engine
    /// regardless of this setting.
    engine_version: ?EngineVersion,

    /// The ARN of the execution role used to access user resources for Spark
    /// sessions and
    /// IAM Identity Center enabled workgroups. This property applies only to Spark
    /// enabled
    /// workgroups and IAM Identity Center enabled workgroups. The property is
    /// required for
    /// IAM Identity Center enabled workgroups.
    execution_role: ?[]const u8,

    /// Specifies whether the workgroup is IAM Identity Center supported.
    identity_center_configuration: ?IdentityCenterConfiguration,

    /// The configuration for storing results in Athena owned storage, which
    /// includes whether
    /// this feature is enabled; whether encryption configuration, if any, is used
    /// for
    /// encrypting query results.
    managed_query_results_configuration: ?ManagedQueryResultsConfiguration,

    /// Contains the configuration settings for managed log persistence, delivering
    /// logs to Amazon S3 buckets,
    /// Amazon CloudWatch log groups etc.
    monitoring_configuration: ?MonitoringConfiguration,

    /// Indicates that the Amazon CloudWatch metrics are enabled for the workgroup.
    publish_cloud_watch_metrics_enabled: ?bool,

    /// Specifies whether Amazon S3 access grants are enabled for query
    /// results.
    query_results_s3_access_grants_configuration: ?QueryResultsS3AccessGrantsConfiguration,

    /// If set to `true`, allows members assigned to a workgroup to reference
    /// Amazon S3 Requester Pays buckets in queries. If set to `false`,
    /// workgroup members cannot query data from Requester Pays buckets, and queries
    /// that
    /// retrieve data from Requester Pays buckets cause an error. The default is
    /// `false`. For more information about Requester Pays buckets, see [Requester
    /// Pays
    /// Buckets](https://docs.aws.amazon.com/AmazonS3/latest/dev/RequesterPaysBuckets.html) in the *Amazon Simple Storage Service Developer
    /// Guide*.
    requester_pays_enabled: ?bool,

    /// The configuration for the workgroup, which includes the location in Amazon
    /// S3
    /// where query and calculation results are stored and the encryption option, if
    /// any, used
    /// for query and calculation results. To run the query, you must specify the
    /// query results
    /// location using one of the ways: either in the workgroup using this setting,
    /// or for
    /// individual queries (client-side), using ResultConfiguration$OutputLocation.
    /// If none of them is set, Athena issues an error that no output location is
    /// provided.
    result_configuration: ?ResultConfiguration,

    pub const json_field_names = .{
        .additional_configuration = "AdditionalConfiguration",
        .bytes_scanned_cutoff_per_query = "BytesScannedCutoffPerQuery",
        .customer_content_encryption_configuration = "CustomerContentEncryptionConfiguration",
        .enable_minimum_encryption_configuration = "EnableMinimumEncryptionConfiguration",
        .enforce_work_group_configuration = "EnforceWorkGroupConfiguration",
        .engine_configuration = "EngineConfiguration",
        .engine_version = "EngineVersion",
        .execution_role = "ExecutionRole",
        .identity_center_configuration = "IdentityCenterConfiguration",
        .managed_query_results_configuration = "ManagedQueryResultsConfiguration",
        .monitoring_configuration = "MonitoringConfiguration",
        .publish_cloud_watch_metrics_enabled = "PublishCloudWatchMetricsEnabled",
        .query_results_s3_access_grants_configuration = "QueryResultsS3AccessGrantsConfiguration",
        .requester_pays_enabled = "RequesterPaysEnabled",
        .result_configuration = "ResultConfiguration",
    };
};
