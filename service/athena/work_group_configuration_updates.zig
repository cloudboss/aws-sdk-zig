const CustomerContentEncryptionConfiguration = @import("customer_content_encryption_configuration.zig").CustomerContentEncryptionConfiguration;
const EngineConfiguration = @import("engine_configuration.zig").EngineConfiguration;
const EngineVersion = @import("engine_version.zig").EngineVersion;
const ManagedQueryResultsConfigurationUpdates = @import("managed_query_results_configuration_updates.zig").ManagedQueryResultsConfigurationUpdates;
const MonitoringConfiguration = @import("monitoring_configuration.zig").MonitoringConfiguration;
const QueryResultsS3AccessGrantsConfiguration = @import("query_results_s3_access_grants_configuration.zig").QueryResultsS3AccessGrantsConfiguration;
const ResultConfigurationUpdates = @import("result_configuration_updates.zig").ResultConfigurationUpdates;

/// The configuration information that will be updated for this workgroup, which
/// includes
/// the location in Amazon S3 where query and calculation results are stored,
/// the
/// encryption option, if any, used for query results, whether the Amazon
/// CloudWatch
/// Metrics are enabled for the workgroup, whether the workgroup settings
/// override the
/// client-side settings, and the data usage limit for the amount of bytes
/// scanned per
/// query, if it is specified.
pub const WorkGroupConfigurationUpdates = struct {
    /// Contains a user defined string in JSON format for a Spark-enabled workgroup.
    additional_configuration: ?[]const u8,

    /// The upper limit (cutoff) for the amount of bytes a single query in a
    /// workgroup is
    /// allowed to scan.
    bytes_scanned_cutoff_per_query: ?i64,

    customer_content_encryption_configuration: ?CustomerContentEncryptionConfiguration,

    /// Enforces a minimal level of encryption for the workgroup for query and
    /// calculation
    /// results that are written to Amazon S3. When enabled, workgroup users can set
    /// encryption only to the minimum level set by the administrator or higher when
    /// they submit
    /// queries. This setting does not apply to Spark-enabled workgroups.
    ///
    /// The `EnforceWorkGroupConfiguration` setting takes precedence over the
    /// `EnableMinimumEncryptionConfiguration` flag. This means that if
    /// `EnforceWorkGroupConfiguration` is true, the
    /// `EnableMinimumEncryptionConfiguration` flag is ignored, and the workgroup
    /// configuration for encryption is used.
    enable_minimum_encryption_configuration: ?bool,

    /// If set to "true", the settings for the workgroup override client-side
    /// settings. If set
    /// to "false" client-side settings are used. For more information, see
    /// [Workgroup Settings Override Client-Side
    /// Settings](https://docs.aws.amazon.com/athena/latest/ug/workgroups-settings-override.html).
    enforce_work_group_configuration: ?bool,

    engine_configuration: ?EngineConfiguration,

    /// The engine version requested when a workgroup is updated. After the update,
    /// all
    /// queries on the workgroup run on the requested engine version. If no value
    /// was previously
    /// set, the default is Auto. Queries on the `AmazonAthenaPreviewFunctionality`
    /// workgroup run on the preview engine regardless of this setting.
    engine_version: ?EngineVersion,

    /// The ARN of the execution role used to access user resources for Spark
    /// sessions and
    /// Identity Center enabled workgroups. This property applies only to Spark
    /// enabled
    /// workgroups and Identity Center enabled workgroups.
    execution_role: ?[]const u8,

    /// Updates configuration information for managed query results in the
    /// workgroup.
    managed_query_results_configuration_updates: ?ManagedQueryResultsConfigurationUpdates,

    /// Contains the configuration settings for managed log persistence, delivering
    /// logs to Amazon S3 buckets,
    /// Amazon CloudWatch log groups etc.
    monitoring_configuration: ?MonitoringConfiguration,

    /// Indicates whether this workgroup enables publishing metrics to Amazon
    /// CloudWatch.
    publish_cloud_watch_metrics_enabled: ?bool,

    /// Specifies whether Amazon S3 access grants are enabled for query
    /// results.
    query_results_s3_access_grants_configuration: ?QueryResultsS3AccessGrantsConfiguration,

    /// Indicates that the data usage control limit per query is removed.
    /// WorkGroupConfiguration$BytesScannedCutoffPerQuery
    remove_bytes_scanned_cutoff_per_query: ?bool,

    /// Removes content encryption configuration from an Apache Spark-enabled Athena
    /// workgroup.
    remove_customer_content_encryption_configuration: ?bool,

    /// If set to `true`, allows members assigned to a workgroup to specify Amazon
    /// S3 Requester Pays buckets in queries. If set to `false`, workgroup
    /// members cannot query data from Requester Pays buckets, and queries that
    /// retrieve data
    /// from Requester Pays buckets cause an error. The default is `false`. For more
    /// information about Requester Pays buckets, see [Requester Pays
    /// Buckets](https://docs.aws.amazon.com/AmazonS3/latest/dev/RequesterPaysBuckets.html)
    /// in the *Amazon Simple Storage Service Developer Guide*.
    requester_pays_enabled: ?bool,

    /// The result configuration information about the queries in this workgroup
    /// that will be
    /// updated. Includes the updated results location and an updated option for
    /// encrypting
    /// query results.
    result_configuration_updates: ?ResultConfigurationUpdates,

    pub const json_field_names = .{
        .additional_configuration = "AdditionalConfiguration",
        .bytes_scanned_cutoff_per_query = "BytesScannedCutoffPerQuery",
        .customer_content_encryption_configuration = "CustomerContentEncryptionConfiguration",
        .enable_minimum_encryption_configuration = "EnableMinimumEncryptionConfiguration",
        .enforce_work_group_configuration = "EnforceWorkGroupConfiguration",
        .engine_configuration = "EngineConfiguration",
        .engine_version = "EngineVersion",
        .execution_role = "ExecutionRole",
        .managed_query_results_configuration_updates = "ManagedQueryResultsConfigurationUpdates",
        .monitoring_configuration = "MonitoringConfiguration",
        .publish_cloud_watch_metrics_enabled = "PublishCloudWatchMetricsEnabled",
        .query_results_s3_access_grants_configuration = "QueryResultsS3AccessGrantsConfiguration",
        .remove_bytes_scanned_cutoff_per_query = "RemoveBytesScannedCutoffPerQuery",
        .remove_customer_content_encryption_configuration = "RemoveCustomerContentEncryptionConfiguration",
        .requester_pays_enabled = "RequesterPaysEnabled",
        .result_configuration_updates = "ResultConfigurationUpdates",
    };
};
