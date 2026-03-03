const aws = @import("aws");
const std = @import("std");

const associate_kms_key = @import("associate_kms_key.zig");
const associate_source_to_s3_table_integration = @import("associate_source_to_s3_table_integration.zig");
const cancel_export_task = @import("cancel_export_task.zig");
const cancel_import_task = @import("cancel_import_task.zig");
const create_delivery = @import("create_delivery.zig");
const create_export_task = @import("create_export_task.zig");
const create_import_task = @import("create_import_task.zig");
const create_log_anomaly_detector = @import("create_log_anomaly_detector.zig");
const create_log_group = @import("create_log_group.zig");
const create_log_stream = @import("create_log_stream.zig");
const create_scheduled_query = @import("create_scheduled_query.zig");
const delete_account_policy = @import("delete_account_policy.zig");
const delete_data_protection_policy = @import("delete_data_protection_policy.zig");
const delete_delivery = @import("delete_delivery.zig");
const delete_delivery_destination = @import("delete_delivery_destination.zig");
const delete_delivery_destination_policy = @import("delete_delivery_destination_policy.zig");
const delete_delivery_source = @import("delete_delivery_source.zig");
const delete_destination = @import("delete_destination.zig");
const delete_index_policy = @import("delete_index_policy.zig");
const delete_integration = @import("delete_integration.zig");
const delete_log_anomaly_detector = @import("delete_log_anomaly_detector.zig");
const delete_log_group = @import("delete_log_group.zig");
const delete_log_stream = @import("delete_log_stream.zig");
const delete_metric_filter = @import("delete_metric_filter.zig");
const delete_query_definition = @import("delete_query_definition.zig");
const delete_resource_policy = @import("delete_resource_policy.zig");
const delete_retention_policy = @import("delete_retention_policy.zig");
const delete_scheduled_query = @import("delete_scheduled_query.zig");
const delete_subscription_filter = @import("delete_subscription_filter.zig");
const delete_transformer = @import("delete_transformer.zig");
const describe_account_policies = @import("describe_account_policies.zig");
const describe_configuration_templates = @import("describe_configuration_templates.zig");
const describe_deliveries = @import("describe_deliveries.zig");
const describe_delivery_destinations = @import("describe_delivery_destinations.zig");
const describe_delivery_sources = @import("describe_delivery_sources.zig");
const describe_destinations = @import("describe_destinations.zig");
const describe_export_tasks = @import("describe_export_tasks.zig");
const describe_field_indexes = @import("describe_field_indexes.zig");
const describe_import_task_batches = @import("describe_import_task_batches.zig");
const describe_import_tasks = @import("describe_import_tasks.zig");
const describe_index_policies = @import("describe_index_policies.zig");
const describe_log_groups = @import("describe_log_groups.zig");
const describe_log_streams = @import("describe_log_streams.zig");
const describe_metric_filters = @import("describe_metric_filters.zig");
const describe_queries = @import("describe_queries.zig");
const describe_query_definitions = @import("describe_query_definitions.zig");
const describe_resource_policies = @import("describe_resource_policies.zig");
const describe_subscription_filters = @import("describe_subscription_filters.zig");
const disassociate_kms_key = @import("disassociate_kms_key.zig");
const disassociate_source_from_s3_table_integration = @import("disassociate_source_from_s3_table_integration.zig");
const filter_log_events = @import("filter_log_events.zig");
const get_data_protection_policy = @import("get_data_protection_policy.zig");
const get_delivery = @import("get_delivery.zig");
const get_delivery_destination = @import("get_delivery_destination.zig");
const get_delivery_destination_policy = @import("get_delivery_destination_policy.zig");
const get_delivery_source = @import("get_delivery_source.zig");
const get_integration = @import("get_integration.zig");
const get_log_anomaly_detector = @import("get_log_anomaly_detector.zig");
const get_log_events = @import("get_log_events.zig");
const get_log_fields = @import("get_log_fields.zig");
const get_log_group_fields = @import("get_log_group_fields.zig");
const get_log_object = @import("get_log_object.zig");
const get_log_record = @import("get_log_record.zig");
const get_query_results = @import("get_query_results.zig");
const get_scheduled_query = @import("get_scheduled_query.zig");
const get_scheduled_query_history = @import("get_scheduled_query_history.zig");
const get_transformer = @import("get_transformer.zig");
const list_aggregate_log_group_summaries = @import("list_aggregate_log_group_summaries.zig");
const list_anomalies = @import("list_anomalies.zig");
const list_integrations = @import("list_integrations.zig");
const list_log_anomaly_detectors = @import("list_log_anomaly_detectors.zig");
const list_log_groups = @import("list_log_groups.zig");
const list_log_groups_for_query = @import("list_log_groups_for_query.zig");
const list_scheduled_queries = @import("list_scheduled_queries.zig");
const list_sources_for_s3_table_integration = @import("list_sources_for_s3_table_integration.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_tags_log_group = @import("list_tags_log_group.zig");
const put_account_policy = @import("put_account_policy.zig");
const put_data_protection_policy = @import("put_data_protection_policy.zig");
const put_delivery_destination = @import("put_delivery_destination.zig");
const put_delivery_destination_policy = @import("put_delivery_destination_policy.zig");
const put_delivery_source = @import("put_delivery_source.zig");
const put_destination = @import("put_destination.zig");
const put_destination_policy = @import("put_destination_policy.zig");
const put_index_policy = @import("put_index_policy.zig");
const put_integration = @import("put_integration.zig");
const put_log_events = @import("put_log_events.zig");
const put_log_group_deletion_protection = @import("put_log_group_deletion_protection.zig");
const put_metric_filter = @import("put_metric_filter.zig");
const put_query_definition = @import("put_query_definition.zig");
const put_resource_policy = @import("put_resource_policy.zig");
const put_retention_policy = @import("put_retention_policy.zig");
const put_subscription_filter = @import("put_subscription_filter.zig");
const put_transformer = @import("put_transformer.zig");
const start_live_tail = @import("start_live_tail.zig");
const start_query = @import("start_query.zig");
const stop_query = @import("stop_query.zig");
const tag_log_group = @import("tag_log_group.zig");
const tag_resource = @import("tag_resource.zig");
const test_metric_filter = @import("test_metric_filter.zig");
const test_transformer = @import("test_transformer.zig");
const untag_log_group = @import("untag_log_group.zig");
const untag_resource = @import("untag_resource.zig");
const update_anomaly = @import("update_anomaly.zig");
const update_delivery_configuration = @import("update_delivery_configuration.zig");
const update_log_anomaly_detector = @import("update_log_anomaly_detector.zig");
const update_scheduled_query = @import("update_scheduled_query.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "CloudWatch Logs";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode }),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode, .request_options = options }),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Associates the specified KMS key with either one log group in the
    /// account, or with all stored CloudWatch Logs query insights results in the
    /// account.
    ///
    /// When you use `AssociateKmsKey`, you specify either the
    /// `logGroupName` parameter or the `resourceIdentifier` parameter. You
    /// can't specify both of those parameters in the same operation.
    ///
    /// * Specify the `logGroupName` parameter to cause log events ingested into
    ///   that
    /// log group to be encrypted with that key. Only the log events ingested after
    /// the key is
    /// associated are encrypted with that key.
    ///
    /// Associating a KMS key with a log group overrides any existing
    /// associations between the log group and a KMS key. After a KMS key is
    /// associated with a log group, all newly ingested data for the log group
    /// is encrypted using the KMS key. This association is stored as long as the
    /// data encrypted with the KMS key is still within CloudWatch Logs. This
    /// enables CloudWatch Logs to decrypt this data whenever it is requested.
    ///
    /// Associating a key with a log group does not cause the results of queries of
    /// that log
    /// group to be encrypted with that key. To have query results encrypted with a
    /// KMS key, you must use an `AssociateKmsKey` operation with the
    /// `resourceIdentifier` parameter that specifies a `query-result`
    /// resource.
    ///
    /// * Specify the `resourceIdentifier` parameter with a `query-result`
    /// resource, to use that key to encrypt the stored results of all future
    /// [StartQuery](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_StartQuery.html) operations in the account. The response from a [GetQueryResults](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_GetQueryResults.html) operation will still return the query results in plain
    /// text.
    ///
    /// Even if you have not associated a key with your query results, the query
    /// results are
    /// encrypted when stored, using the default CloudWatch Logs method.
    ///
    /// If you run a query from a monitoring account that queries logs in a source
    /// account,
    /// the query results key from the monitoring account, if any, is used.
    ///
    /// If you delete the key that is used to encrypt log events or log group query
    /// results,
    /// then all the associated stored log events or query results that were
    /// encrypted with that key
    /// will be unencryptable and unusable.
    ///
    /// CloudWatch Logs supports only symmetric KMS keys. Do not associate an
    /// asymmetric KMS key with your log group or query results. For more
    /// information, see [Using Symmetric and Asymmetric
    /// Keys](https://docs.aws.amazon.com/kms/latest/developerguide/symmetric-asymmetric.html).
    ///
    /// It can take up to 5 minutes for this operation to take effect.
    ///
    /// If you attempt to associate a KMS key with a log group but the KMS key does
    /// not exist or the KMS key is disabled, you receive an
    /// `InvalidParameterException` error.
    pub fn associateKmsKey(self: *Self, allocator: std.mem.Allocator, input: associate_kms_key.AssociateKmsKeyInput, options: CallOptions) !associate_kms_key.AssociateKmsKeyOutput {
        return associate_kms_key.execute(self, allocator, input, options);
    }

    /// Associates a data source with an S3 Table Integration for query access in
    /// the 'logs'
    /// namespace. This enables querying log data using analytics engines that
    /// support Iceberg such as
    /// Amazon Athena, Amazon Redshift, and Apache Spark.
    pub fn associateSourceToS3TableIntegration(self: *Self, allocator: std.mem.Allocator, input: associate_source_to_s3_table_integration.AssociateSourceToS3TableIntegrationInput, options: CallOptions) !associate_source_to_s3_table_integration.AssociateSourceToS3TableIntegrationOutput {
        return associate_source_to_s3_table_integration.execute(self, allocator, input, options);
    }

    /// Cancels the specified export task.
    ///
    /// The task must be in the `PENDING` or `RUNNING` state.
    pub fn cancelExportTask(self: *Self, allocator: std.mem.Allocator, input: cancel_export_task.CancelExportTaskInput, options: CallOptions) !cancel_export_task.CancelExportTaskOutput {
        return cancel_export_task.execute(self, allocator, input, options);
    }

    /// Cancels an active import task and stops importing data from the CloudTrail
    /// Lake Event Data Store.
    pub fn cancelImportTask(self: *Self, allocator: std.mem.Allocator, input: cancel_import_task.CancelImportTaskInput, options: CallOptions) !cancel_import_task.CancelImportTaskOutput {
        return cancel_import_task.execute(self, allocator, input, options);
    }

    /// Creates a *delivery*. A delivery is a connection between a logical
    /// *delivery source* and a logical *delivery destination*
    /// that you have already created.
    ///
    /// Only some Amazon Web Services services support being configured as a
    /// delivery source using
    /// this operation. These services are listed as **Supported [V2
    /// Permissions]** in the table at [Enabling logging from
    /// Amazon Web Services
    /// services.](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/AWS-logs-and-resource-policy.html)
    ///
    /// A delivery destination can represent a log group in CloudWatch Logs, an
    /// Amazon S3 bucket, a delivery stream in Firehose, or X-Ray.
    ///
    /// To configure logs delivery between a supported Amazon Web Services service
    /// and a
    /// destination, you must do the following:
    ///
    /// * Create a delivery source, which is a logical object that represents the
    ///   resource that
    /// is actually sending the logs. For more information, see
    /// [PutDeliverySource](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_PutDeliverySource.html).
    ///
    /// * Create a *delivery destination*, which is a logical object that
    /// represents the actual delivery destination. For more information, see
    /// [PutDeliveryDestination](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_PutDeliveryDestination.html).
    ///
    /// * If you are delivering logs cross-account, you must use
    ///   [PutDeliveryDestinationPolicy](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_PutDeliveryDestinationPolicy.html) in the destination account to assign an IAM policy to the destination. This policy allows delivery to that destination.
    ///
    /// * Use `CreateDelivery` to create a *delivery* by pairing
    /// exactly one delivery source and one delivery destination.
    ///
    /// You can configure a single delivery source to send logs to multiple
    /// destinations by
    /// creating multiple deliveries. You can also create multiple deliveries to
    /// configure multiple
    /// delivery sources to send logs to the same delivery destination.
    ///
    /// To update an existing delivery configuration, use
    /// [UpdateDeliveryConfiguration](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_UpdateDeliveryConfiguration.html).
    pub fn createDelivery(self: *Self, allocator: std.mem.Allocator, input: create_delivery.CreateDeliveryInput, options: CallOptions) !create_delivery.CreateDeliveryOutput {
        return create_delivery.execute(self, allocator, input, options);
    }

    /// Creates an export task so that you can efficiently export data from a log
    /// group to an
    /// Amazon S3 bucket. When you perform a `CreateExportTask` operation, you must
    /// use
    /// credentials that have permission to write to the S3 bucket that you specify
    /// as the
    /// destination.
    ///
    /// Exporting log data to S3 buckets that are encrypted by KMS is supported.
    /// Exporting log data to Amazon S3 buckets that have S3 Object Lock enabled
    /// with a
    /// retention period is also supported.
    ///
    /// Exporting to S3 buckets that are encrypted with AES-256 is supported.
    ///
    /// This is an asynchronous call. If all the required information is provided,
    /// this
    /// operation initiates an export task and responds with the ID of the task.
    /// After the task has
    /// started, you can use
    /// [DescribeExportTasks](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_DescribeExportTasks.html) to get the status of the export task. Each account can only
    /// have one active (`RUNNING` or `PENDING`) export task at a time. To
    /// cancel an export task, use
    /// [CancelExportTask](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_CancelExportTask.html).
    ///
    /// You can export logs from multiple log groups or multiple time ranges to the
    /// same S3
    /// bucket. To separate log data for each export task, specify a prefix to be
    /// used as the Amazon
    /// S3 key prefix for all exported objects.
    ///
    /// We recommend that you don't regularly export to Amazon S3 as a way to
    /// continuously archive your logs. For that use case, we instead recommend that
    /// you use
    /// subscriptions. For more information about subscriptions, see [Real-time
    /// processing of log data
    /// with
    /// subscriptions](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/Subscriptions.html).
    ///
    /// Time-based sorting on chunks of log data inside an exported file is not
    /// guaranteed. You
    /// can sort the exported log field data by using Linux utilities.
    pub fn createExportTask(self: *Self, allocator: std.mem.Allocator, input: create_export_task.CreateExportTaskInput, options: CallOptions) !create_export_task.CreateExportTaskOutput {
        return create_export_task.execute(self, allocator, input, options);
    }

    /// Starts an import from a data source to CloudWatch Log and creates a managed
    /// log group as the destination for the imported data.
    /// Currently, [CloudTrail Event Data
    /// Store](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/query-event-data-store.html) is the only supported data source.
    ///
    /// The import task must satisfy the following constraints:
    ///
    /// * The specified source must be in an ACTIVE state.
    ///
    /// * The API caller must have permissions to access the data in the provided
    ///   source and to perform iam:PassRole on the
    /// provided import role which has the same permissions, as described below.
    ///
    /// * The provided IAM role must trust the "cloudtrail.amazonaws.com" principal
    ///   and have the following permissions:
    ///
    /// * cloudtrail:GetEventDataStoreData
    ///
    /// * logs:CreateLogGroup
    ///
    /// * logs:CreateLogStream
    ///
    /// * logs:PutResourcePolicy
    ///
    /// * (If source has an associated AWS KMS Key) kms:Decrypt
    ///
    /// * (If source has an associated AWS KMS Key) kms:GenerateDataKey
    ///
    /// Example IAM policy for provided import role:
    ///
    /// `[ { "Effect": "Allow", "Action": "iam:PassRole", "Resource":
    /// "arn:aws:iam::123456789012:role/apiCallerCredentials", "Condition": {
    /// "StringLike": { "iam:AssociatedResourceARN":
    /// "arn:aws:logs:us-east-1:123456789012:log-group:aws/cloudtrail/f1d45bff-d0e3-4868-b5d9-2eb678aa32fb:*" } } }, { "Effect": "Allow", "Action": [ "cloudtrail:GetEventDataStoreData" ], "Resource": [ "arn:aws:cloudtrail:us-east-1:123456789012:eventdatastore/f1d45bff-d0e3-4868-b5d9-2eb678aa32fb" ] }, { "Effect": "Allow", "Action": [ "logs:CreateImportTask", "logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutResourcePolicy" ], "Resource": [ "arn:aws:logs:us-east-1:123456789012:log-group:/aws/cloudtrail/*" ] }, { "Effect": "Allow", "Action": [ "kms:Decrypt", "kms:GenerateDataKey" ], "Resource": [ "arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012" ] } ]`
    ///
    /// * If the import source has a customer managed key, the
    ///   "cloudtrail.amazonaws.com" principal needs permissions to perform
    ///   kms:Decrypt and kms:GenerateDataKey.
    ///
    /// * There can be no more than 3 active imports per account at a given time.
    ///
    /// * The startEventTime must be less than or equal to endEventTime.
    ///
    /// * The data being imported must be within the specified source's retention
    ///   period.
    pub fn createImportTask(self: *Self, allocator: std.mem.Allocator, input: create_import_task.CreateImportTaskInput, options: CallOptions) !create_import_task.CreateImportTaskOutput {
        return create_import_task.execute(self, allocator, input, options);
    }

    /// Creates an *anomaly detector* that regularly scans one or more log
    /// groups and look for patterns and anomalies in the logs.
    ///
    /// An anomaly detector can help surface issues by automatically discovering
    /// anomalies in your
    /// log event traffic. An anomaly detector uses machine learning algorithms to
    /// scan log events and
    /// find *patterns*. A pattern is a shared text structure that recurs among
    /// your log fields. Patterns provide a useful tool for analyzing large sets of
    /// logs because a
    /// large number of log events can often be compressed into a few patterns.
    ///
    /// The anomaly detector uses pattern recognition to find `anomalies`, which are
    /// unusual log events. It uses the `evaluationFrequency` to compare current log
    /// events
    /// and patterns with trained baselines.
    ///
    /// Fields within a pattern are called *tokens*. Fields that vary within a
    /// pattern, such as a request ID or timestamp, are referred to as *dynamic
    /// tokens* and represented by ``.
    ///
    /// The following is an example of a pattern:
    ///
    /// `[INFO] Request time: ms`
    ///
    /// This pattern represents log events like `[INFO] Request time: 327 ms` and
    /// other
    /// similar log events that differ only by the number, in this csse 327. When
    /// the pattern is
    /// displayed, the different numbers are replaced by ``
    ///
    /// Any parts of log events that are masked as sensitive data are not scanned
    /// for anomalies.
    /// For more information about masking sensitive data, see [Help protect
    /// sensitive log
    /// data with
    /// masking](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/mask-sensitive-log-data.html).
    pub fn createLogAnomalyDetector(self: *Self, allocator: std.mem.Allocator, input: create_log_anomaly_detector.CreateLogAnomalyDetectorInput, options: CallOptions) !create_log_anomaly_detector.CreateLogAnomalyDetectorOutput {
        return create_log_anomaly_detector.execute(self, allocator, input, options);
    }

    /// Creates a log group with the specified name. You can create up to 1,000,000
    /// log groups
    /// per Region per account.
    ///
    /// You must use the following guidelines when naming a log group:
    ///
    /// * Log group names must be unique within a Region for an Amazon Web Services
    /// account.
    ///
    /// * Log group names can be between 1 and 512 characters long.
    ///
    /// * Log group names consist of the following characters: a-z, A-Z, 0-9, '_'
    /// (underscore), '-' (hyphen), '/' (forward slash), '.' (period), and '#'
    /// (number
    /// sign)
    ///
    /// * Log group names can't start with the string `aws/`
    ///
    /// When you create a log group, by default the log events in the log group do
    /// not expire.
    /// To set a retention policy so that events expire and are deleted after a
    /// specified time, use
    /// [PutRetentionPolicy](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_PutRetentionPolicy.html).
    ///
    /// If you associate an KMS key with the log group, ingested data is
    /// encrypted using the KMS key. This association is stored as long as the data
    /// encrypted with the KMS key is still within CloudWatch Logs. This enables
    /// CloudWatch Logs to decrypt this data whenever it is requested.
    ///
    /// If you attempt to associate a KMS key with the log group but the KMS key
    /// does not exist or the KMS key is disabled, you receive an
    /// `InvalidParameterException` error.
    ///
    /// CloudWatch Logs supports only symmetric KMS keys. Do not associate an
    /// asymmetric KMS key with your log group. For more information, see [Using
    /// Symmetric and Asymmetric
    /// Keys](https://docs.aws.amazon.com/kms/latest/developerguide/symmetric-asymmetric.html).
    pub fn createLogGroup(self: *Self, allocator: std.mem.Allocator, input: create_log_group.CreateLogGroupInput, options: CallOptions) !create_log_group.CreateLogGroupOutput {
        return create_log_group.execute(self, allocator, input, options);
    }

    /// Creates a log stream for the specified log group. A log stream is a sequence
    /// of log
    /// events that originate from a single source, such as an application instance
    /// or a resource that
    /// is being monitored.
    ///
    /// There is no limit on the number of log streams that you can create for a log
    /// group.
    /// There is a limit of 50 TPS on `CreateLogStream` operations, after which
    /// transactions are throttled.
    ///
    /// You must use the following guidelines when naming a log stream:
    ///
    /// * Log stream names must be unique within the log group.
    ///
    /// * Log stream names can be between 1 and 512 characters long.
    ///
    /// * Don't use ':' (colon) or '*' (asterisk) characters.
    pub fn createLogStream(self: *Self, allocator: std.mem.Allocator, input: create_log_stream.CreateLogStreamInput, options: CallOptions) !create_log_stream.CreateLogStreamOutput {
        return create_log_stream.execute(self, allocator, input, options);
    }

    /// Creates a scheduled query that runs CloudWatch Logs Insights queries at
    /// regular intervals.
    /// Scheduled queries enable proactive monitoring by automatically executing
    /// queries to detect
    /// patterns and anomalies in your log data. Query results can be delivered to
    /// Amazon S3 for analysis
    /// or further processing.
    pub fn createScheduledQuery(self: *Self, allocator: std.mem.Allocator, input: create_scheduled_query.CreateScheduledQueryInput, options: CallOptions) !create_scheduled_query.CreateScheduledQueryOutput {
        return create_scheduled_query.execute(self, allocator, input, options);
    }

    /// Deletes a CloudWatch Logs account policy. This stops the account-wide policy
    /// from
    /// applying to log groups or data sources in the account. If you delete a data
    /// protection policy
    /// or subscription filter policy, any log-group level policies of those types
    /// remain in effect.
    /// This operation supports deletion of data source-based field index policies,
    /// including facet
    /// configurations, in addition to log group-based policies.
    ///
    /// To use this operation, you must be signed on with the correct permissions
    /// depending on the
    /// type of policy that you are deleting.
    ///
    /// * To delete a data protection policy, you must have the
    /// `logs:DeleteDataProtectionPolicy` and `logs:DeleteAccountPolicy`
    /// permissions.
    ///
    /// * To delete a subscription filter policy, you must have the
    /// `logs:DeleteSubscriptionFilter` and `logs:DeleteAccountPolicy`
    /// permissions.
    ///
    /// * To delete a transformer policy, you must have the `logs:DeleteTransformer`
    /// and `logs:DeleteAccountPolicy` permissions.
    ///
    /// * To delete a field index policy, you must have the `logs:DeleteIndexPolicy`
    /// and `logs:DeleteAccountPolicy` permissions.
    ///
    /// If you delete a field index policy that included facet configurations, those
    /// facets
    /// will no longer be available for interactive exploration in the CloudWatch
    /// Logs Insights
    /// console. However, facet data is retained for up to 30 days.
    ///
    /// If you delete a field index policy, the indexing of the log events that
    /// happened before
    /// you deleted the policy will still be used for up to 30 days to improve
    /// CloudWatch Logs
    /// Insights queries.
    pub fn deleteAccountPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_account_policy.DeleteAccountPolicyInput, options: CallOptions) !delete_account_policy.DeleteAccountPolicyOutput {
        return delete_account_policy.execute(self, allocator, input, options);
    }

    /// Deletes the data protection policy from the specified log group.
    ///
    /// For more information about data protection policies, see
    /// [PutDataProtectionPolicy](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_PutDataProtectionPolicy.html).
    pub fn deleteDataProtectionPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_data_protection_policy.DeleteDataProtectionPolicyInput, options: CallOptions) !delete_data_protection_policy.DeleteDataProtectionPolicyOutput {
        return delete_data_protection_policy.execute(self, allocator, input, options);
    }

    /// Deletes a *delivery*. A delivery is a connection between a logical
    /// *delivery source* and a logical *delivery
    /// destination*. Deleting a delivery only deletes the connection between the
    /// delivery
    /// source and delivery destination. It does not delete the delivery destination
    /// or the delivery
    /// source.
    pub fn deleteDelivery(self: *Self, allocator: std.mem.Allocator, input: delete_delivery.DeleteDeliveryInput, options: CallOptions) !delete_delivery.DeleteDeliveryOutput {
        return delete_delivery.execute(self, allocator, input, options);
    }

    /// Deletes a *delivery destination*. A delivery is a connection between a
    /// logical *delivery source* and a logical *delivery
    /// destination*.
    ///
    /// You can't delete a delivery destination if any current deliveries are
    /// associated with it.
    /// To find whether any deliveries are associated with this delivery
    /// destination, use the
    /// [DescribeDeliveries](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_DescribeDeliveries.html) operation and check the `deliveryDestinationArn`
    /// field in the results.
    pub fn deleteDeliveryDestination(self: *Self, allocator: std.mem.Allocator, input: delete_delivery_destination.DeleteDeliveryDestinationInput, options: CallOptions) !delete_delivery_destination.DeleteDeliveryDestinationOutput {
        return delete_delivery_destination.execute(self, allocator, input, options);
    }

    /// Deletes a delivery destination policy. For more information about these
    /// policies, see
    /// [PutDeliveryDestinationPolicy](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_PutDeliveryDestinationPolicy.html).
    pub fn deleteDeliveryDestinationPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_delivery_destination_policy.DeleteDeliveryDestinationPolicyInput, options: CallOptions) !delete_delivery_destination_policy.DeleteDeliveryDestinationPolicyOutput {
        return delete_delivery_destination_policy.execute(self, allocator, input, options);
    }

    /// Deletes a *delivery source*. A delivery is a connection between a
    /// logical *delivery source* and a logical *delivery
    /// destination*.
    ///
    /// You can't delete a delivery source if any current deliveries are associated
    /// with it. To
    /// find whether any deliveries are associated with this delivery source, use
    /// the
    /// [DescribeDeliveries](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_DescribeDeliveries.html) operation and check the `deliverySourceName` field in
    /// the results.
    pub fn deleteDeliverySource(self: *Self, allocator: std.mem.Allocator, input: delete_delivery_source.DeleteDeliverySourceInput, options: CallOptions) !delete_delivery_source.DeleteDeliverySourceOutput {
        return delete_delivery_source.execute(self, allocator, input, options);
    }

    /// Deletes the specified destination, and eventually disables all the
    /// subscription filters
    /// that publish to it. This operation does not delete the physical resource
    /// encapsulated by the
    /// destination.
    pub fn deleteDestination(self: *Self, allocator: std.mem.Allocator, input: delete_destination.DeleteDestinationInput, options: CallOptions) !delete_destination.DeleteDestinationOutput {
        return delete_destination.execute(self, allocator, input, options);
    }

    /// Deletes a log-group level field index policy that was applied to a single
    /// log group. The
    /// indexing of the log events that happened before you delete the policy will
    /// still be used for
    /// as many as 30 days to improve CloudWatch Logs Insights queries.
    ///
    /// If the deleted policy included facet configurations, those facets will no
    /// longer be
    /// available for interactive exploration in the CloudWatch Logs Insights
    /// console for this log
    /// group. However, facet data is retained for up to 30 days.
    ///
    /// You can't use this operation to delete an account-level index policy.
    /// Instead, use
    /// [DeleteAccountPolicy](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_DeleteAccountPolicy.html).
    ///
    /// If you delete a log-group level field index policy and there is an
    /// account-level field
    /// index policy, in a few minutes the log group begins using that account-wide
    /// policy to index
    /// new incoming log events. This operation only affects log group-level
    /// policies, including any
    /// facet configurations, and preserves any data source-based account policies
    /// that may apply to
    /// the log group.
    pub fn deleteIndexPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_index_policy.DeleteIndexPolicyInput, options: CallOptions) !delete_index_policy.DeleteIndexPolicyOutput {
        return delete_index_policy.execute(self, allocator, input, options);
    }

    /// Deletes the integration between CloudWatch Logs and OpenSearch Service. If
    /// your
    /// integration has active vended logs dashboards, you must specify `true` for
    /// the
    /// `force` parameter, otherwise the operation will fail. If you delete the
    /// integration by setting `force` to `true`, all your vended logs
    /// dashboards powered by OpenSearch Service will be deleted and the data that
    /// was on them will no
    /// longer be accessible.
    pub fn deleteIntegration(self: *Self, allocator: std.mem.Allocator, input: delete_integration.DeleteIntegrationInput, options: CallOptions) !delete_integration.DeleteIntegrationOutput {
        return delete_integration.execute(self, allocator, input, options);
    }

    /// Deletes the specified CloudWatch Logs anomaly detector.
    pub fn deleteLogAnomalyDetector(self: *Self, allocator: std.mem.Allocator, input: delete_log_anomaly_detector.DeleteLogAnomalyDetectorInput, options: CallOptions) !delete_log_anomaly_detector.DeleteLogAnomalyDetectorOutput {
        return delete_log_anomaly_detector.execute(self, allocator, input, options);
    }

    /// Deletes the specified log group and permanently deletes all the archived log
    /// events
    /// associated with the log group.
    pub fn deleteLogGroup(self: *Self, allocator: std.mem.Allocator, input: delete_log_group.DeleteLogGroupInput, options: CallOptions) !delete_log_group.DeleteLogGroupOutput {
        return delete_log_group.execute(self, allocator, input, options);
    }

    /// Deletes the specified log stream and permanently deletes all the archived
    /// log events
    /// associated with the log stream.
    pub fn deleteLogStream(self: *Self, allocator: std.mem.Allocator, input: delete_log_stream.DeleteLogStreamInput, options: CallOptions) !delete_log_stream.DeleteLogStreamOutput {
        return delete_log_stream.execute(self, allocator, input, options);
    }

    /// Deletes the specified metric filter.
    pub fn deleteMetricFilter(self: *Self, allocator: std.mem.Allocator, input: delete_metric_filter.DeleteMetricFilterInput, options: CallOptions) !delete_metric_filter.DeleteMetricFilterOutput {
        return delete_metric_filter.execute(self, allocator, input, options);
    }

    /// Deletes a saved CloudWatch Logs Insights query definition. A query
    /// definition contains
    /// details about a saved CloudWatch Logs Insights query.
    ///
    /// Each `DeleteQueryDefinition` operation can delete one query definition.
    ///
    /// You must have the `logs:DeleteQueryDefinition` permission to be able to
    /// perform
    /// this operation.
    pub fn deleteQueryDefinition(self: *Self, allocator: std.mem.Allocator, input: delete_query_definition.DeleteQueryDefinitionInput, options: CallOptions) !delete_query_definition.DeleteQueryDefinitionOutput {
        return delete_query_definition.execute(self, allocator, input, options);
    }

    /// Deletes a resource policy from this account. This revokes the access of the
    /// identities
    /// in that policy to put log events to this account.
    pub fn deleteResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: delete_resource_policy.DeleteResourcePolicyInput, options: CallOptions) !delete_resource_policy.DeleteResourcePolicyOutput {
        return delete_resource_policy.execute(self, allocator, input, options);
    }

    /// Deletes the specified retention policy.
    ///
    /// Log events do not expire if they belong to log groups without a retention
    /// policy.
    pub fn deleteRetentionPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_retention_policy.DeleteRetentionPolicyInput, options: CallOptions) !delete_retention_policy.DeleteRetentionPolicyOutput {
        return delete_retention_policy.execute(self, allocator, input, options);
    }

    /// Deletes a scheduled query and stops all future executions. This operation
    /// also removes any
    /// configured actions and associated resources.
    pub fn deleteScheduledQuery(self: *Self, allocator: std.mem.Allocator, input: delete_scheduled_query.DeleteScheduledQueryInput, options: CallOptions) !delete_scheduled_query.DeleteScheduledQueryOutput {
        return delete_scheduled_query.execute(self, allocator, input, options);
    }

    /// Deletes the specified subscription filter.
    pub fn deleteSubscriptionFilter(self: *Self, allocator: std.mem.Allocator, input: delete_subscription_filter.DeleteSubscriptionFilterInput, options: CallOptions) !delete_subscription_filter.DeleteSubscriptionFilterOutput {
        return delete_subscription_filter.execute(self, allocator, input, options);
    }

    /// Deletes the log transformer for the specified log group. As soon as you do
    /// this, the
    /// transformation of incoming log events according to that transformer stops.
    /// If this account has
    /// an account-level transformer that applies to this log group, the log group
    /// begins using that
    /// account-level transformer when this log-group level transformer is deleted.
    ///
    /// After you delete a transformer, be sure to edit any metric filters or
    /// subscription filters
    /// that relied on the transformed versions of the log events.
    pub fn deleteTransformer(self: *Self, allocator: std.mem.Allocator, input: delete_transformer.DeleteTransformerInput, options: CallOptions) !delete_transformer.DeleteTransformerOutput {
        return delete_transformer.execute(self, allocator, input, options);
    }

    /// Returns a list of all CloudWatch Logs account policies in the account.
    ///
    /// To use this operation, you must be signed on with the correct permissions
    /// depending on the
    /// type of policy that you are retrieving information for.
    ///
    /// * To see data protection policies, you must have the
    /// `logs:GetDataProtectionPolicy` and `logs:DescribeAccountPolicies`
    /// permissions.
    ///
    /// * To see subscription filter policies, you must have the
    /// `logs:DescribeSubscriptionFilters` and
    /// `logs:DescribeAccountPolicies` permissions.
    ///
    /// * To see transformer policies, you must have the `logs:GetTransformer` and
    /// `logs:DescribeAccountPolicies` permissions.
    ///
    /// * To see field index policies, you must have the
    ///   `logs:DescribeIndexPolicies`
    /// and `logs:DescribeAccountPolicies` permissions.
    pub fn describeAccountPolicies(self: *Self, allocator: std.mem.Allocator, input: describe_account_policies.DescribeAccountPoliciesInput, options: CallOptions) !describe_account_policies.DescribeAccountPoliciesOutput {
        return describe_account_policies.execute(self, allocator, input, options);
    }

    /// Use this operation to return the valid and default values that are used when
    /// creating
    /// delivery sources, delivery destinations, and deliveries. For more
    /// information about
    /// deliveries, see
    /// [CreateDelivery](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_CreateDelivery.html).
    pub fn describeConfigurationTemplates(self: *Self, allocator: std.mem.Allocator, input: describe_configuration_templates.DescribeConfigurationTemplatesInput, options: CallOptions) !describe_configuration_templates.DescribeConfigurationTemplatesOutput {
        return describe_configuration_templates.execute(self, allocator, input, options);
    }

    /// Retrieves a list of the deliveries that have been created in the account.
    ///
    /// A *delivery* is a connection between a [
    /// *delivery
    /// source*
    /// ](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_PutDeliverySource.html) and a [
    /// *delivery destination*
    /// ](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_PutDeliveryDestination.html).
    ///
    /// A delivery source represents an Amazon Web Services resource that sends logs
    /// to an logs
    /// delivery destination. The destination can be CloudWatch Logs, Amazon S3,
    /// Firehose or X-Ray. Only some Amazon Web Services services support being
    /// configured as a delivery source. These services are listed in [Enable
    /// logging from
    /// Amazon Web Services
    /// services.](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/AWS-logs-and-resource-policy.html)
    pub fn describeDeliveries(self: *Self, allocator: std.mem.Allocator, input: describe_deliveries.DescribeDeliveriesInput, options: CallOptions) !describe_deliveries.DescribeDeliveriesOutput {
        return describe_deliveries.execute(self, allocator, input, options);
    }

    /// Retrieves a list of the delivery destinations that have been created in the
    /// account.
    pub fn describeDeliveryDestinations(self: *Self, allocator: std.mem.Allocator, input: describe_delivery_destinations.DescribeDeliveryDestinationsInput, options: CallOptions) !describe_delivery_destinations.DescribeDeliveryDestinationsOutput {
        return describe_delivery_destinations.execute(self, allocator, input, options);
    }

    /// Retrieves a list of the delivery sources that have been created in the
    /// account.
    pub fn describeDeliverySources(self: *Self, allocator: std.mem.Allocator, input: describe_delivery_sources.DescribeDeliverySourcesInput, options: CallOptions) !describe_delivery_sources.DescribeDeliverySourcesOutput {
        return describe_delivery_sources.execute(self, allocator, input, options);
    }

    /// Lists all your destinations. The results are ASCII-sorted by destination
    /// name.
    pub fn describeDestinations(self: *Self, allocator: std.mem.Allocator, input: describe_destinations.DescribeDestinationsInput, options: CallOptions) !describe_destinations.DescribeDestinationsOutput {
        return describe_destinations.execute(self, allocator, input, options);
    }

    /// Lists the specified export tasks. You can list all your export tasks or
    /// filter the
    /// results based on task ID or task status.
    pub fn describeExportTasks(self: *Self, allocator: std.mem.Allocator, input: describe_export_tasks.DescribeExportTasksInput, options: CallOptions) !describe_export_tasks.DescribeExportTasksOutput {
        return describe_export_tasks.execute(self, allocator, input, options);
    }

    /// Returns a list of custom and default field indexes which are discovered in
    /// log data. For
    /// more information about field index policies, see
    /// [PutIndexPolicy](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_PutIndexPolicy.html).
    pub fn describeFieldIndexes(self: *Self, allocator: std.mem.Allocator, input: describe_field_indexes.DescribeFieldIndexesInput, options: CallOptions) !describe_field_indexes.DescribeFieldIndexesOutput {
        return describe_field_indexes.execute(self, allocator, input, options);
    }

    /// Gets detailed information about the individual batches within an import
    /// task, including their status and any error messages.
    /// For CloudTrail Event Data Store sources, a batch refers to a subset of
    /// stored events grouped by their eventTime.
    pub fn describeImportTaskBatches(self: *Self, allocator: std.mem.Allocator, input: describe_import_task_batches.DescribeImportTaskBatchesInput, options: CallOptions) !describe_import_task_batches.DescribeImportTaskBatchesOutput {
        return describe_import_task_batches.execute(self, allocator, input, options);
    }

    /// Lists and describes import tasks, with optional filtering by import status
    /// and source ARN.
    pub fn describeImportTasks(self: *Self, allocator: std.mem.Allocator, input: describe_import_tasks.DescribeImportTasksInput, options: CallOptions) !describe_import_tasks.DescribeImportTasksOutput {
        return describe_import_tasks.execute(self, allocator, input, options);
    }

    /// Returns the field index policies of the specified log group. For more
    /// information about
    /// field index policies, see
    /// [PutIndexPolicy](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_PutIndexPolicy.html).
    ///
    /// If a specified log group has a log-group level index policy, that policy is
    /// returned by
    /// this operation.
    ///
    /// If a specified log group doesn't have a log-group level index policy, but an
    /// account-wide
    /// index policy applies to it, that account-wide policy is returned by this
    /// operation.
    ///
    /// To find information about only account-level policies, use
    /// [DescribeAccountPolicies](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_DescribeAccountPolicies.html) instead.
    pub fn describeIndexPolicies(self: *Self, allocator: std.mem.Allocator, input: describe_index_policies.DescribeIndexPoliciesInput, options: CallOptions) !describe_index_policies.DescribeIndexPoliciesOutput {
        return describe_index_policies.execute(self, allocator, input, options);
    }

    /// Returns information about log groups, including data sources that ingest
    /// into each log
    /// group. You can return all your log groups or filter the results by prefix.
    /// The results are
    /// ASCII-sorted by log group name.
    ///
    /// CloudWatch Logs doesn't support IAM policies that control access to the
    /// `DescribeLogGroups` action by using the
    /// `aws:ResourceTag/*key-name*
    /// ` condition key. Other CloudWatch
    /// Logs actions do support the use of the
    /// `aws:ResourceTag/*key-name*
    /// ` condition key to control access.
    /// For more information about using tags to control access, see [Controlling
    /// access to Amazon Web Services
    /// resources using
    /// tags](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_tags.html).
    ///
    /// If you are using CloudWatch cross-account observability, you can use this
    /// operation
    /// in a monitoring account and view data from the linked source accounts. For
    /// more information,
    /// see [CloudWatch cross-account
    /// observability](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-Unified-Cross-Account.html).
    pub fn describeLogGroups(self: *Self, allocator: std.mem.Allocator, input: describe_log_groups.DescribeLogGroupsInput, options: CallOptions) !describe_log_groups.DescribeLogGroupsOutput {
        return describe_log_groups.execute(self, allocator, input, options);
    }

    /// Lists the log streams for the specified log group. You can list all the log
    /// streams or
    /// filter the results by prefix. You can also control how the results are
    /// ordered.
    ///
    /// You can specify the log group to search by using either `logGroupIdentifier`
    /// or
    /// `logGroupName`. You must include one of these two parameters, but you can't
    /// include both.
    ///
    /// This operation has a limit of 25 transactions per second, after which
    /// transactions are
    /// throttled.
    ///
    /// If you are using CloudWatch cross-account observability, you can use this
    /// operation
    /// in a monitoring account and view data from the linked source accounts. For
    /// more information,
    /// see [CloudWatch cross-account
    /// observability](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-Unified-Cross-Account.html).
    pub fn describeLogStreams(self: *Self, allocator: std.mem.Allocator, input: describe_log_streams.DescribeLogStreamsInput, options: CallOptions) !describe_log_streams.DescribeLogStreamsOutput {
        return describe_log_streams.execute(self, allocator, input, options);
    }

    /// Lists the specified metric filters. You can list all of the metric filters
    /// or filter
    /// the results by log name, prefix, metric name, or metric namespace. The
    /// results are
    /// ASCII-sorted by filter name.
    pub fn describeMetricFilters(self: *Self, allocator: std.mem.Allocator, input: describe_metric_filters.DescribeMetricFiltersInput, options: CallOptions) !describe_metric_filters.DescribeMetricFiltersOutput {
        return describe_metric_filters.execute(self, allocator, input, options);
    }

    /// Returns a list of CloudWatch Logs Insights queries that are scheduled,
    /// running, or have
    /// been run recently in this account. You can request all queries or limit it
    /// to queries of a
    /// specific log group or queries with a certain status.
    ///
    /// This operation includes both interactive queries started directly by users
    /// and automated
    /// queries executed by scheduled query configurations. Scheduled query
    /// executions appear in the
    /// results alongside manually initiated queries, providing visibility into all
    /// query activity in
    /// your account.
    pub fn describeQueries(self: *Self, allocator: std.mem.Allocator, input: describe_queries.DescribeQueriesInput, options: CallOptions) !describe_queries.DescribeQueriesOutput {
        return describe_queries.execute(self, allocator, input, options);
    }

    /// This operation returns a paginated list of your saved CloudWatch Logs
    /// Insights query
    /// definitions. You can retrieve query definitions from the current account or
    /// from a source
    /// account that is linked to the current account.
    ///
    /// You can use the `queryDefinitionNamePrefix` parameter to limit the results
    /// to
    /// only the query definitions that have names that start with a certain string.
    pub fn describeQueryDefinitions(self: *Self, allocator: std.mem.Allocator, input: describe_query_definitions.DescribeQueryDefinitionsInput, options: CallOptions) !describe_query_definitions.DescribeQueryDefinitionsOutput {
        return describe_query_definitions.execute(self, allocator, input, options);
    }

    /// Lists the resource policies in this account.
    pub fn describeResourcePolicies(self: *Self, allocator: std.mem.Allocator, input: describe_resource_policies.DescribeResourcePoliciesInput, options: CallOptions) !describe_resource_policies.DescribeResourcePoliciesOutput {
        return describe_resource_policies.execute(self, allocator, input, options);
    }

    /// Lists the subscription filters for the specified log group. You can list all
    /// the
    /// subscription filters or filter the results by prefix. The results are
    /// ASCII-sorted by filter
    /// name.
    pub fn describeSubscriptionFilters(self: *Self, allocator: std.mem.Allocator, input: describe_subscription_filters.DescribeSubscriptionFiltersInput, options: CallOptions) !describe_subscription_filters.DescribeSubscriptionFiltersOutput {
        return describe_subscription_filters.execute(self, allocator, input, options);
    }

    /// Disassociates the specified KMS key from the specified log group or
    /// from all CloudWatch Logs Insights query results in the account.
    ///
    /// When you use `DisassociateKmsKey`, you specify either the
    /// `logGroupName` parameter or the `resourceIdentifier` parameter. You
    /// can't specify both of those parameters in the same operation.
    ///
    /// * Specify the `logGroupName` parameter to stop using the KMS key to encrypt
    ///   future log events ingested and stored in the log group.
    /// Instead, they will be encrypted with the default CloudWatch Logs method. The
    /// log events
    /// that were ingested while the key was associated with the log group are still
    /// encrypted
    /// with that key. Therefore, CloudWatch Logs will need permissions for the key
    /// whenever
    /// that data is accessed.
    ///
    /// * Specify the `resourceIdentifier` parameter with the
    /// `query-result` resource to stop using the KMS key to
    /// encrypt the results of all future
    /// [StartQuery](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_StartQuery.html)
    /// operations in the account. They will instead be encrypted with the default
    /// CloudWatch Logs method. The results from queries that ran while the key was
    /// associated with
    /// the account are still encrypted with that key. Therefore, CloudWatch Logs
    /// will need
    /// permissions for the key whenever that data is accessed.
    ///
    /// It can take up to 5 minutes for this operation to take effect.
    pub fn disassociateKmsKey(self: *Self, allocator: std.mem.Allocator, input: disassociate_kms_key.DisassociateKmsKeyInput, options: CallOptions) !disassociate_kms_key.DisassociateKmsKeyOutput {
        return disassociate_kms_key.execute(self, allocator, input, options);
    }

    /// Disassociates a data source from an S3 Table Integration, removing query
    /// access and
    /// deleting all associated data from the integration.
    pub fn disassociateSourceFromS3TableIntegration(self: *Self, allocator: std.mem.Allocator, input: disassociate_source_from_s3_table_integration.DisassociateSourceFromS3TableIntegrationInput, options: CallOptions) !disassociate_source_from_s3_table_integration.DisassociateSourceFromS3TableIntegrationOutput {
        return disassociate_source_from_s3_table_integration.execute(self, allocator, input, options);
    }

    /// Lists log events from the specified log group. You can list all the log
    /// events or
    /// filter the results using one or more of the following:
    ///
    /// * A filter pattern
    ///
    /// * A time range
    ///
    /// * The log stream name, or a log stream name prefix that matches multiple log
    /// streams
    ///
    /// You must have the `logs:FilterLogEvents` permission to perform this
    /// operation.
    ///
    /// You can specify the log group to search by using either `logGroupIdentifier`
    /// or
    /// `logGroupName`. You must include one of these two parameters, but you can't
    /// include both.
    ///
    /// `FilterLogEvents` is a paginated operation. Each page returned can contain
    /// up
    /// to 1 MB of log events or up to 10,000 log events. A returned page might only
    /// be partially
    /// full, or even empty. For example, if the result of a query would return
    /// 15,000 log events, the
    /// first page isn't guaranteed to have 10,000 log events even if they all fit
    /// into 1 MB.
    ///
    /// Partially full or empty pages don't necessarily mean that pagination is
    /// finished. If the
    /// results include a `nextToken`, there might be more log events available. You
    /// can
    /// return these additional log events by providing the nextToken in a
    /// subsequent
    /// `FilterLogEvents` operation. If the results don't include a
    /// `nextToken`, then pagination is finished.
    ///
    /// Specifying the `limit` parameter only guarantees that a single page doesn't
    /// return more log events than the specified limit, but it might return fewer
    /// events than the
    /// limit. This is the expected API behavior.
    ///
    /// The returned log events are sorted by event timestamp, the timestamp when
    /// the event was
    /// ingested by CloudWatch Logs, and the ID of the `PutLogEvents` request.
    ///
    /// If you are using CloudWatch cross-account observability, you can use this
    /// operation
    /// in a monitoring account and view data from the linked source accounts. For
    /// more information,
    /// see [CloudWatch cross-account
    /// observability](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-Unified-Cross-Account.html).
    ///
    /// If you are using [log
    /// transformation](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html), the `FilterLogEvents` operation returns only the
    /// original versions of log events, before they were transformed. To view the
    /// transformed
    /// versions, you must use a [CloudWatch Logs
    /// query.](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/AnalyzingLogData.html)
    pub fn filterLogEvents(self: *Self, allocator: std.mem.Allocator, input: filter_log_events.FilterLogEventsInput, options: CallOptions) !filter_log_events.FilterLogEventsOutput {
        return filter_log_events.execute(self, allocator, input, options);
    }

    /// Returns information about a log group data protection policy.
    pub fn getDataProtectionPolicy(self: *Self, allocator: std.mem.Allocator, input: get_data_protection_policy.GetDataProtectionPolicyInput, options: CallOptions) !get_data_protection_policy.GetDataProtectionPolicyOutput {
        return get_data_protection_policy.execute(self, allocator, input, options);
    }

    /// Returns complete information about one logical *delivery*. A delivery
    /// is a connection between a [
    /// *delivery
    /// source*
    /// ](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_PutDeliverySource.html) and a [
    /// *delivery destination*
    /// ](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_PutDeliveryDestination.html).
    ///
    /// A delivery source represents an Amazon Web Services resource that sends logs
    /// to an logs
    /// delivery destination. The destination can be CloudWatch Logs, Amazon S3, or
    /// Firehose. Only some Amazon Web Services services support being configured as
    /// a delivery
    /// source. These services are listed in [Enable logging from
    /// Amazon Web Services
    /// services.](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/AWS-logs-and-resource-policy.html)
    ///
    /// You need to specify the delivery `id` in this operation. You can find the
    /// IDs
    /// of the deliveries in your account with the
    /// [DescribeDeliveries](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_DescribeDeliveries.html) operation.
    pub fn getDelivery(self: *Self, allocator: std.mem.Allocator, input: get_delivery.GetDeliveryInput, options: CallOptions) !get_delivery.GetDeliveryOutput {
        return get_delivery.execute(self, allocator, input, options);
    }

    /// Retrieves complete information about one delivery destination.
    pub fn getDeliveryDestination(self: *Self, allocator: std.mem.Allocator, input: get_delivery_destination.GetDeliveryDestinationInput, options: CallOptions) !get_delivery_destination.GetDeliveryDestinationOutput {
        return get_delivery_destination.execute(self, allocator, input, options);
    }

    /// Retrieves the delivery destination policy assigned to the delivery
    /// destination that you
    /// specify. For more information about delivery destinations and their
    /// policies, see
    /// [PutDeliveryDestinationPolicy](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_PutDeliveryDestinationPolicy.html).
    pub fn getDeliveryDestinationPolicy(self: *Self, allocator: std.mem.Allocator, input: get_delivery_destination_policy.GetDeliveryDestinationPolicyInput, options: CallOptions) !get_delivery_destination_policy.GetDeliveryDestinationPolicyOutput {
        return get_delivery_destination_policy.execute(self, allocator, input, options);
    }

    /// Retrieves complete information about one delivery source.
    pub fn getDeliverySource(self: *Self, allocator: std.mem.Allocator, input: get_delivery_source.GetDeliverySourceInput, options: CallOptions) !get_delivery_source.GetDeliverySourceOutput {
        return get_delivery_source.execute(self, allocator, input, options);
    }

    /// Returns information about one integration between CloudWatch Logs and
    /// OpenSearch Service.
    pub fn getIntegration(self: *Self, allocator: std.mem.Allocator, input: get_integration.GetIntegrationInput, options: CallOptions) !get_integration.GetIntegrationOutput {
        return get_integration.execute(self, allocator, input, options);
    }

    /// Retrieves information about the log anomaly detector that you specify. The
    /// KMS key ARN detected is valid.
    pub fn getLogAnomalyDetector(self: *Self, allocator: std.mem.Allocator, input: get_log_anomaly_detector.GetLogAnomalyDetectorInput, options: CallOptions) !get_log_anomaly_detector.GetLogAnomalyDetectorOutput {
        return get_log_anomaly_detector.execute(self, allocator, input, options);
    }

    /// Lists log events from the specified log stream. You can list all of the log
    /// events or
    /// filter using a time range.
    ///
    /// `GetLogEvents` is a paginated operation. Each page returned can contain up
    /// to 1
    /// MB of log events or up to 10,000 log events. A returned page might only be
    /// partially full, or
    /// even empty. For example, if the result of a query would return 15,000 log
    /// events, the first
    /// page isn't guaranteed to have 10,000 log events even if they all fit into 1
    /// MB.
    ///
    /// Partially full or empty pages don't necessarily mean that pagination is
    /// finished. As long
    /// as the `nextBackwardToken` or `nextForwardToken` returned is NOT equal
    /// to the `nextToken` that you passed into the API call, there might be more
    /// log
    /// events available. The token that you use depends on the direction you want
    /// to move in along
    /// the log stream. The returned tokens are never null.
    ///
    /// If you set `startFromHead` to `true` and you don’t include
    /// `endTime` in your request, you can end up in a situation where the
    /// pagination
    /// doesn't terminate. This can happen when the new log events are being added
    /// to the target log
    /// streams faster than they are being read. This situation is a good use case
    /// for the CloudWatch Logs
    /// [Live
    /// Tail](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatchLogs_LiveTail.html) feature.
    ///
    /// If you are using CloudWatch cross-account observability, you can use this
    /// operation
    /// in a monitoring account and view data from the linked source accounts. For
    /// more information,
    /// see [CloudWatch cross-account
    /// observability](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-Unified-Cross-Account.html).
    ///
    /// You can specify the log group to search by using either `logGroupIdentifier`
    /// or
    /// `logGroupName`. You must include one of these two parameters, but you can't
    /// include both.
    ///
    /// If you are using [log
    /// transformation](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html), the `GetLogEvents` operation returns only the original
    /// versions of log events, before they were transformed. To view the
    /// transformed versions, you
    /// must use a [CloudWatch Logs
    /// query.](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/AnalyzingLogData.html)
    pub fn getLogEvents(self: *Self, allocator: std.mem.Allocator, input: get_log_events.GetLogEventsInput, options: CallOptions) !get_log_events.GetLogEventsOutput {
        return get_log_events.execute(self, allocator, input, options);
    }

    /// Discovers available fields for a specific data source and type. The response
    /// includes any
    /// field modifications introduced through pipelines, such as new fields or
    /// changed field types.
    pub fn getLogFields(self: *Self, allocator: std.mem.Allocator, input: get_log_fields.GetLogFieldsInput, options: CallOptions) !get_log_fields.GetLogFieldsOutput {
        return get_log_fields.execute(self, allocator, input, options);
    }

    /// Returns a list of the fields that are included in log events in the
    /// specified log group.
    /// Includes the percentage of log events that contain each field. The search is
    /// limited to a time
    /// period that you specify.
    ///
    /// This operation is used for discovering fields within log group events. For
    /// discovering
    /// fields across data sources, use the GetLogFields operation.
    ///
    /// You can specify the log group to search by using either `logGroupIdentifier`
    /// or
    /// `logGroupName`. You must specify one of these parameters, but you can't
    /// specify
    /// both.
    ///
    /// In the results, fields that start with `@` are fields generated by
    /// CloudWatch
    /// Logs. For example, `@timestamp` is the timestamp of each log event. For more
    /// information about the fields that are generated by CloudWatch logs, see
    /// [Supported
    /// Logs and Discovered
    /// Fields](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CWL_AnalyzeLogData-discoverable-fields.html).
    ///
    /// The response results are sorted by the frequency percentage, starting with
    /// the highest
    /// percentage.
    ///
    /// If you are using CloudWatch cross-account observability, you can use this
    /// operation
    /// in a monitoring account and view data from the linked source accounts. For
    /// more information,
    /// see [CloudWatch cross-account
    /// observability](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-Unified-Cross-Account.html).
    pub fn getLogGroupFields(self: *Self, allocator: std.mem.Allocator, input: get_log_group_fields.GetLogGroupFieldsInput, options: CallOptions) !get_log_group_fields.GetLogGroupFieldsOutput {
        return get_log_group_fields.execute(self, allocator, input, options);
    }

    /// Retrieves a large logging object (LLO) and streams it back. This API is used
    /// to fetch the
    /// content of large portions of log events that have been ingested through the
    /// PutOpenTelemetryLogs API. When log events contain fields that would cause
    /// the total event size
    /// to exceed 1MB, CloudWatch Logs automatically processes up to 10 fields,
    /// starting with the
    /// largest fields. Each field is truncated as needed to keep the total event
    /// size as close to 1MB
    /// as possible. The excess portions are stored as Large Log Objects (LLOs) and
    /// these fields are
    /// processed separately and LLO reference system fields (in the format
    /// `@ptr.$[path.to.field]`) are added. The path in the reference field reflects
    /// the
    /// original JSON structure where the large field was located. For example, this
    /// could be
    /// `@ptr.$['input']['message']`, `@ptr.$['AAA']['BBB']['CCC']['DDD']`,
    /// `@ptr.$['AAA']`, or any other path matching your log structure.
    pub fn getLogObject(self: *Self, allocator: std.mem.Allocator, input: get_log_object.GetLogObjectInput, options: CallOptions) !get_log_object.GetLogObjectOutput {
        return get_log_object.execute(self, allocator, input, options);
    }

    /// Retrieves all of the fields and values of a single log event. All fields are
    /// retrieved,
    /// even if the original query that produced the `logRecordPointer` retrieved
    /// only a
    /// subset of fields. Fields are returned as field name/field value pairs.
    ///
    /// The full unparsed log event is returned within `@message`.
    pub fn getLogRecord(self: *Self, allocator: std.mem.Allocator, input: get_log_record.GetLogRecordInput, options: CallOptions) !get_log_record.GetLogRecordOutput {
        return get_log_record.execute(self, allocator, input, options);
    }

    /// Returns the results from the specified query.
    ///
    /// Only the fields requested in the query are returned, along with a `@ptr`
    /// field,
    /// which is the identifier for the log record. You can use the value of `@ptr`
    /// in a
    /// [GetLogRecord](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_GetLogRecord.html)
    /// operation to get the full log record.
    ///
    /// `GetQueryResults` does not start running a query. To run a query, use
    /// [StartQuery](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_StartQuery.html). For more information about how long results of previous queries are
    /// available, see [CloudWatch Logs
    /// quotas](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/cloudwatch_limits_cwl.html).
    ///
    /// If the value of the `Status` field in the output is `Running`, this
    /// operation returns only partial results. If you see a value of `Scheduled` or
    /// `Running` for the status, you can retry the operation later to see the final
    /// results.
    ///
    /// This operation is used both for retrieving results from interactive queries
    /// and from
    /// automated scheduled query executions. Scheduled queries use
    /// `GetQueryResults`
    /// internally to retrieve query results for processing and delivery to
    /// configured
    /// destinations.
    ///
    /// If you are using CloudWatch cross-account observability, you can use this
    /// operation
    /// in a monitoring account to start queries in linked source accounts. For more
    /// information, see
    /// [CloudWatch cross-account
    /// observability](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-Unified-Cross-Account.html).
    pub fn getQueryResults(self: *Self, allocator: std.mem.Allocator, input: get_query_results.GetQueryResultsInput, options: CallOptions) !get_query_results.GetQueryResultsOutput {
        return get_query_results.execute(self, allocator, input, options);
    }

    /// Retrieves details about a specific scheduled query, including its
    /// configuration, execution
    /// status, and metadata.
    pub fn getScheduledQuery(self: *Self, allocator: std.mem.Allocator, input: get_scheduled_query.GetScheduledQueryInput, options: CallOptions) !get_scheduled_query.GetScheduledQueryOutput {
        return get_scheduled_query.execute(self, allocator, input, options);
    }

    /// Retrieves the execution history of a scheduled query within a specified time
    /// range,
    /// including query results and destination processing status.
    pub fn getScheduledQueryHistory(self: *Self, allocator: std.mem.Allocator, input: get_scheduled_query_history.GetScheduledQueryHistoryInput, options: CallOptions) !get_scheduled_query_history.GetScheduledQueryHistoryOutput {
        return get_scheduled_query_history.execute(self, allocator, input, options);
    }

    /// Returns the information about the log transformer associated with this log
    /// group.
    ///
    /// This operation returns data only for transformers created at the log group
    /// level. To get
    /// information for an account-level transformer, use
    /// [DescribeAccountPolicies](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_DescribeAccountPolicies.html).
    pub fn getTransformer(self: *Self, allocator: std.mem.Allocator, input: get_transformer.GetTransformerInput, options: CallOptions) !get_transformer.GetTransformerOutput {
        return get_transformer.execute(self, allocator, input, options);
    }

    /// Returns an aggregate summary of all log groups in the Region grouped by
    /// specified data
    /// source characteristics. Supports optional filtering by log group class, name
    /// patterns, and
    /// data sources. If you perform this action in a monitoring account, you can
    /// also return
    /// aggregated summaries of log groups from source accounts that are linked to
    /// the monitoring
    /// account. For more information about using cross-account observability to set
    /// up monitoring
    /// accounts and source accounts, see [CloudWatch
    /// cross-account
    /// observability](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-Unified-Cross-Account.html).
    ///
    /// The operation aggregates log groups by data source name and type and
    /// optionally format,
    /// providing counts of log groups that share these characteristics. The
    /// operation paginates
    /// results. By default, it returns up to 50 results and includes a token to
    /// retrieve more
    /// results.
    pub fn listAggregateLogGroupSummaries(self: *Self, allocator: std.mem.Allocator, input: list_aggregate_log_group_summaries.ListAggregateLogGroupSummariesInput, options: CallOptions) !list_aggregate_log_group_summaries.ListAggregateLogGroupSummariesOutput {
        return list_aggregate_log_group_summaries.execute(self, allocator, input, options);
    }

    /// Returns a list of anomalies that log anomaly detectors have found. For
    /// details about the
    /// structure format of each anomaly object that is returned, see the example in
    /// this
    /// section.
    pub fn listAnomalies(self: *Self, allocator: std.mem.Allocator, input: list_anomalies.ListAnomaliesInput, options: CallOptions) !list_anomalies.ListAnomaliesOutput {
        return list_anomalies.execute(self, allocator, input, options);
    }

    /// Returns a list of integrations between CloudWatch Logs and other services in
    /// this
    /// account. Currently, only one integration can be created in an account, and
    /// this integration
    /// must be with OpenSearch Service.
    pub fn listIntegrations(self: *Self, allocator: std.mem.Allocator, input: list_integrations.ListIntegrationsInput, options: CallOptions) !list_integrations.ListIntegrationsOutput {
        return list_integrations.execute(self, allocator, input, options);
    }

    /// Retrieves a list of the log anomaly detectors in the account.
    pub fn listLogAnomalyDetectors(self: *Self, allocator: std.mem.Allocator, input: list_log_anomaly_detectors.ListLogAnomalyDetectorsInput, options: CallOptions) !list_log_anomaly_detectors.ListLogAnomalyDetectorsOutput {
        return list_log_anomaly_detectors.execute(self, allocator, input, options);
    }

    /// Returns a list of log groups in the Region in your account. If you are
    /// performing this
    /// action in a monitoring account, you can choose to also return log groups
    /// from source accounts
    /// that are linked to the monitoring account. For more information about using
    /// cross-account
    /// observability to set up monitoring accounts and source accounts, see [
    /// CloudWatch cross-account
    /// observability](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-Unified-Cross-Account.html).
    ///
    /// You can optionally filter the list by log group class, by using regular
    /// expressions in
    /// your request to match strings in the log group names, by using the
    /// fieldIndexes parameter to
    /// filter log groups based on which field indexes are configured, by using the
    /// dataSources
    /// parameter to filter log groups by data source types, and by using the
    /// fieldIndexNames
    /// parameter to filter by specific field index names.
    ///
    /// This operation is paginated. By default, your first use of this operation
    /// returns 50
    /// results, and includes a token to use in a subsequent operation to return
    /// more results.
    pub fn listLogGroups(self: *Self, allocator: std.mem.Allocator, input: list_log_groups.ListLogGroupsInput, options: CallOptions) !list_log_groups.ListLogGroupsOutput {
        return list_log_groups.execute(self, allocator, input, options);
    }

    /// Returns a list of the log groups that were analyzed during a single
    /// CloudWatch Logs
    /// Insights query. This can be useful for queries that use log group name
    /// prefixes or the
    /// `filterIndex` command, because the log groups are dynamically selected in
    /// these
    /// cases.
    ///
    /// For more information about field indexes, see [Create field indexes
    /// to improve query performance and reduce
    /// costs](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatchLogs-Field-Indexing.html).
    pub fn listLogGroupsForQuery(self: *Self, allocator: std.mem.Allocator, input: list_log_groups_for_query.ListLogGroupsForQueryInput, options: CallOptions) !list_log_groups_for_query.ListLogGroupsForQueryOutput {
        return list_log_groups_for_query.execute(self, allocator, input, options);
    }

    /// Lists all scheduled queries in your account and region. You can filter
    /// results by state to
    /// show only enabled or disabled queries.
    pub fn listScheduledQueries(self: *Self, allocator: std.mem.Allocator, input: list_scheduled_queries.ListScheduledQueriesInput, options: CallOptions) !list_scheduled_queries.ListScheduledQueriesOutput {
        return list_scheduled_queries.execute(self, allocator, input, options);
    }

    /// Returns a list of data source associations for a specified S3 Table
    /// Integration, showing
    /// which data sources are currently associated for query access.
    pub fn listSourcesForS3TableIntegration(self: *Self, allocator: std.mem.Allocator, input: list_sources_for_s3_table_integration.ListSourcesForS3TableIntegrationInput, options: CallOptions) !list_sources_for_s3_table_integration.ListSourcesForS3TableIntegrationOutput {
        return list_sources_for_s3_table_integration.execute(self, allocator, input, options);
    }

    /// Displays the tags associated with a CloudWatch Logs resource. Currently, log
    /// groups and
    /// destinations support tagging.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// The ListTagsLogGroup operation is on the path to deprecation. We recommend
    /// that you use
    /// [ListTagsForResource](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_ListTagsForResource.html) instead.
    ///
    /// Lists the tags for the specified log group.
    pub fn listTagsLogGroup(self: *Self, allocator: std.mem.Allocator, input: list_tags_log_group.ListTagsLogGroupInput, options: CallOptions) !list_tags_log_group.ListTagsLogGroupOutput {
        return list_tags_log_group.execute(self, allocator, input, options);
    }

    /// Creates an account-level data protection policy, subscription filter policy,
    /// field index
    /// policy, transformer policy, or metric extraction policy that applies to all
    /// log groups, a
    /// subset of log groups, or a data source name and type combination in the
    /// account.
    ///
    /// For field index policies, you can configure indexed fields as *facets*
    /// to enable interactive exploration of your logs. Facets provide value
    /// distributions and counts
    /// for indexed fields in the CloudWatch Logs Insights console without requiring
    /// query
    /// execution. For more information, see [Use facets to group and
    /// explore
    /// logs](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatchLogs-Facets.html).
    ///
    /// To use this operation, you must be signed on with the correct permissions
    /// depending on the
    /// type of policy that you are creating.
    ///
    /// * To create a data protection policy, you must have the
    /// `logs:PutDataProtectionPolicy` and `logs:PutAccountPolicy`
    /// permissions.
    ///
    /// * To create a subscription filter policy, you must have the
    /// `logs:PutSubscriptionFilter` and `logs:PutAccountPolicy`
    /// permissions.
    ///
    /// * To create a transformer policy, you must have the `logs:PutTransformer`
    ///   and
    /// `logs:PutAccountPolicy` permissions.
    ///
    /// * To create a field index policy, you must have the `logs:PutIndexPolicy`
    ///   and
    /// `logs:PutAccountPolicy` permissions.
    ///
    /// * To configure facets for field index policies, you must have the
    /// `logs:PutIndexPolicy` and `logs:PutAccountPolicy`
    /// permissions.
    ///
    /// * To create a metric extraction policy, you must have the
    /// `logs:PutMetricExtractionPolicy` and `logs:PutAccountPolicy`
    /// permissions.
    ///
    /// **Data protection policy**
    ///
    /// A data protection policy can help safeguard sensitive data that's ingested
    /// by your log
    /// groups by auditing and masking the sensitive log data. Each account can have
    /// only one
    /// account-level data protection policy.
    ///
    /// Sensitive data is detected and masked when it is ingested into a log group.
    /// When you set
    /// a data protection policy, log events ingested into the log groups before
    /// that time are not
    /// masked.
    ///
    /// If you use `PutAccountPolicy` to create a data protection policy for your
    /// whole
    /// account, it applies to both existing log groups and all log groups that are
    /// created later in
    /// this account. The account-level policy is applied to existing log groups
    /// with eventual
    /// consistency. It might take up to 5 minutes before sensitive data in existing
    /// log groups begins
    /// to be masked.
    ///
    /// By default, when a user views a log event that includes masked data, the
    /// sensitive data is
    /// replaced by asterisks. A user who has the `logs:Unmask` permission can use a
    /// [GetLogEvents](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_GetLogEvents.html) or [FilterLogEvents](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_FilterLogEvents.html) operation with the `unmask` parameter set to
    /// `true` to view the unmasked log events. Users with the `logs:Unmask`
    /// can also view unmasked data in the CloudWatch Logs console by running a
    /// CloudWatch Logs
    /// Insights query with the `unmask` query command.
    ///
    /// For more information, including a list of types of data that can be audited
    /// and masked,
    /// see [Protect sensitive log data
    /// with
    /// masking](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/mask-sensitive-log-data.html).
    ///
    /// To use the `PutAccountPolicy` operation for a data protection policy, you
    /// must
    /// be signed on with the `logs:PutDataProtectionPolicy` and
    /// `logs:PutAccountPolicy` permissions.
    ///
    /// The `PutAccountPolicy` operation applies to all log groups in the account.
    /// You
    /// can use
    /// [PutDataProtectionPolicy](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_PutDataProtectionPolicy.html) to create a data protection policy that applies to just one
    /// log group. If a log group has its own data protection policy and the account
    /// also has an
    /// account-level data protection policy, then the two policies are cumulative.
    /// Any sensitive term
    /// specified in either policy is masked.
    ///
    /// **Subscription filter policy**
    ///
    /// A subscription filter policy sets up a real-time feed of log events from
    /// CloudWatch Logs to other Amazon Web Services services. Account-level
    /// subscription filter policies apply to
    /// both existing log groups and log groups that are created later in this
    /// account. Supported
    /// destinations are Kinesis Data Streams, Firehose, and Lambda. When log
    /// events are sent to the receiving service, they are Base64 encoded and
    /// compressed with the GZIP
    /// format.
    ///
    /// The following destinations are supported for subscription filters:
    ///
    /// * An Kinesis Data Streams data stream in the same account as the
    ///   subscription policy, for
    /// same-account delivery.
    ///
    /// * An Firehose data stream in the same account as the subscription policy,
    ///   for
    /// same-account delivery.
    ///
    /// * A Lambda function in the same account as the subscription policy, for
    /// same-account delivery.
    ///
    /// * A logical destination in a different account created with
    ///   [PutDestination](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_PutDestination.html), for cross-account delivery. Kinesis Data Streams and Firehose are supported as logical destinations.
    ///
    /// Each account can have one account-level subscription filter policy per
    /// Region. If you are
    /// updating an existing filter, you must specify the correct name in
    /// `PolicyName`. To
    /// perform a `PutAccountPolicy` subscription filter operation for any
    /// destination
    /// except a Lambda function, you must also have the `iam:PassRole`
    /// permission.
    ///
    /// **Transformer policy**
    ///
    /// Creates or updates a *log transformer policy* for your account. You use
    /// log transformers to transform log events into a different format, making
    /// them easier for you
    /// to process and analyze. You can also transform logs from different sources
    /// into standardized
    /// formats that contain relevant, source-specific information. After you have
    /// created a
    /// transformer, CloudWatch Logs performs this transformation at the time of log
    /// ingestion. You
    /// can then refer to the transformed versions of the logs during operations
    /// such as querying with
    /// CloudWatch Logs Insights or creating metric filters or subscription filters.
    ///
    /// You can also use a transformer to copy metadata from metadata keys into the
    /// log events
    /// themselves. This metadata can include log group name, log stream name,
    /// account ID and
    /// Region.
    ///
    /// A transformer for a log group is a series of processors, where each
    /// processor applies one
    /// type of transformation to the log events ingested into this log group. For
    /// more information
    /// about the available processors to use in a transformer, see [ Processors
    /// that you can
    /// use](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-Processors).
    ///
    /// Having log events in standardized format enables visibility across your
    /// applications for
    /// your log analysis, reporting, and alarming needs. CloudWatch Logs provides
    /// transformation
    /// for common log types with out-of-the-box transformation templates for major
    /// Amazon Web Services
    /// log sources such as VPC flow logs, Lambda, and Amazon RDS. You can use
    /// pre-built transformation templates or create custom transformation policies.
    ///
    /// You can create transformers only for the log groups in the Standard log
    /// class.
    ///
    /// You can have one account-level transformer policy that applies to all log
    /// groups in the
    /// account. Or you can create as many as 20 account-level transformer policies
    /// that are each
    /// scoped to a subset of log groups with the `selectionCriteria` parameter. If
    /// you
    /// have multiple account-level transformer policies with selection criteria, no
    /// two of them can
    /// use the same or overlapping log group name prefixes. For example, if you
    /// have one policy
    /// filtered to log groups that start with `my-log`, you can't have another
    /// transformer
    /// policy filtered to `my-logpprod` or `my-logging`.
    ///
    /// You can also set up a transformer at the log-group level. For more
    /// information, see
    /// [PutTransformer](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_PutTransformer.html). If there is both a log-group level transformer created with
    /// `PutTransformer` and an account-level transformer that could apply to the
    /// same
    /// log group, the log group uses only the log-group level transformer. It
    /// ignores the
    /// account-level transformer.
    ///
    /// **Field index policy**
    ///
    /// You can use field index policies to create indexes on fields found in log
    /// events for a log
    /// group or data source name and type combination. Creating field indexes can
    /// help lower the scan
    /// volume for CloudWatch Logs Insights queries that reference those fields,
    /// because these
    /// queries attempt to skip the processing of log events that are known to not
    /// match the indexed
    /// field. Good fields to index are fields that you often need to query for and
    /// fields or values
    /// that match only a small fraction of the total log events. Common examples of
    /// indexes include
    /// request ID, session ID, user IDs, or instance IDs. For more information, see
    /// [Create field indexes to improve query performance and reduce
    /// costs](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatchLogs-Field-Indexing.html)
    ///
    /// To find the fields that are in your log group events, use the
    /// [GetLogGroupFields](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_GetLogGroupFields.html) operation. To find the fields for a data source use the [GetLogFields](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_GetLogFields.html) operation.
    ///
    /// For example, suppose you have created a field index for `requestId`. Then,
    /// any
    /// CloudWatch Logs Insights query on that log group that includes `requestId =
    /// *value*
    /// ` or `requestId in [*value*,
    /// *value*, ...]` will attempt to process only the log events where
    /// the indexed field matches the specified value.
    ///
    /// Matches of log events to the names of indexed fields are case-sensitive. For
    /// example, an
    /// indexed field of `RequestId` won't match a log event containing
    /// `requestId`.
    ///
    /// You can have one account-level field index policy that applies to all log
    /// groups in the
    /// account. Or you can create as many as 20 account-level field index policies
    /// that are each
    /// scoped to a subset of log groups using `LogGroupNamePrefix` with the
    /// `selectionCriteria` parameter. You can have another 20 account-level field
    /// index
    /// policies using `DataSourceName` and `DataSourceType` for the
    /// `selectionCriteria` parameter. If you have multiple account-level index
    /// policies
    /// with `LogGroupNamePrefix` selection criteria, no two of them can use the
    /// same or
    /// overlapping log group name prefixes. For example, if you have one policy
    /// filtered to log
    /// groups that start with *my-log*, you can't have another field index policy
    /// filtered to *my-logpprod* or *my-logging*. Similarly, if
    /// you have multiple account-level index policies with `DataSourceName` and
    /// `DataSourceType` selection criteria, no two of them can use the same data
    /// source
    /// name and type combination. For example, if you have one policy filtered to
    /// the data source
    /// name `amazon_vpc` and data source type `flow` you cannot create another
    /// policy with this combination.
    ///
    /// If you create an account-level field index policy in a monitoring account in
    /// cross-account
    /// observability, the policy is applied only to the monitoring account and not
    /// to any source
    /// accounts.
    ///
    /// CloudWatch Logs provides default field indexes for all log groups in the
    /// Standard log
    /// class. Default field indexes are automatically available for the following
    /// fields:
    ///
    /// * `@logStream`
    ///
    /// * `@aws.region`
    ///
    /// * `@aws.account`
    ///
    /// * `@source.log`
    ///
    /// * `@data_source_name`
    ///
    /// * `@data_source_type`
    ///
    /// * `@data_format`
    ///
    /// * `traceId`
    ///
    /// * `severityText`
    ///
    /// * `attributes.session.id`
    ///
    /// CloudWatch Logs provides default field indexes for certain data source name
    /// and type
    /// combinations as well. Default field indexes are automatically available for
    /// the following data
    /// source name and type combinations as identified in the following list:
    ///
    /// `amazon_vpc.flow`
    ///
    /// * `action`
    ///
    /// * `logStatus`
    ///
    /// * `region`
    ///
    /// * `flowDirection`
    ///
    /// * `type`
    ///
    /// `amazon_route53.resolver_query`
    ///
    /// * `transport`
    ///
    /// * `rcode`
    ///
    /// `aws_waf.access`
    ///
    /// * `action`
    ///
    /// * `httpRequest.country`
    ///
    /// `aws_cloudtrail.data`, `aws_cloudtrail.management`
    ///
    /// * `eventSource`
    ///
    /// * `eventName`
    ///
    /// * `awsRegion`
    ///
    /// * `userAgent`
    ///
    /// * `errorCode`
    ///
    /// * `eventType`
    ///
    /// * `managementEvent`
    ///
    /// * `readOnly`
    ///
    /// * `eventCategory`
    ///
    /// * `requestId`
    ///
    /// Default field indexes are in addition to any custom field indexes you define
    /// within your
    /// policy. Default field indexes are not counted towards your [field index
    /// quota](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatchLogs-Field-Indexing-Syntax).
    ///
    /// If you want to create a field index policy for a single log group, you can
    /// use
    /// [PutIndexPolicy](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_PutIndexPolicy.html) instead of `PutAccountPolicy`. If you do so, that log
    /// group will use that log-group level policy and any account-level policies
    /// that match at the
    /// data source level; any account-level policy that matches at the log group
    /// level (for example,
    /// no selection criteria or log group name prefix selection criteria) will be
    /// ignored.
    ///
    /// **Metric extraction policy**
    ///
    /// A metric extraction policy controls whether CloudWatch Metrics can be
    /// created through the
    /// Embedded Metrics Format (EMF) for log groups in your account. By default,
    /// EMF metric creation
    /// is enabled for all log groups. You can use metric extraction policies to
    /// disable EMF metric
    /// creation for your entire account or specific log groups.
    ///
    /// When a policy disables EMF metric creation for a log group, log events in
    /// the EMF format
    /// are still ingested, but no CloudWatch Metrics are created from them.
    ///
    /// Creating a policy disables metrics for AWS features that use EMF to create
    /// metrics, such
    /// as CloudWatch Container Insights and CloudWatch Application Signals. To
    /// prevent turning off
    /// those features by accident, we recommend that you exclude the underlying
    /// log-groups through
    /// a selection-criteria such as `LogGroupNamePrefix NOT IN
    /// ["/aws/containerinsights",
    /// "/aws/ecs/containerinsights", "/aws/application-signals/data"]`.
    ///
    /// Each account can have either one account-level metric extraction policy that
    /// applies to
    /// all log groups, or up to 5 policies that are each scoped to a subset of log
    /// groups with the
    /// `selectionCriteria` parameter. The selection criteria supports filtering by
    /// `LogGroupName` and `LogGroupNamePrefix` using the operators
    /// `IN` and `NOT IN`. You can specify up to 50 values in each
    /// `IN` or `NOT IN` list.
    ///
    /// The selection criteria can be specified in these formats:
    ///
    /// `LogGroupName IN ["log-group-1", "log-group-2"]`
    ///
    /// `LogGroupNamePrefix NOT IN ["/aws/prefix1", "/aws/prefix2"]`
    ///
    /// If you have multiple account-level metric extraction policies with selection
    /// criteria, no
    /// two of them can have overlapping criteria. For example, if you have one
    /// policy with selection
    /// criteria `LogGroupNamePrefix IN ["my-log"]`, you can't have another metric
    /// extraction policy with selection criteria `LogGroupNamePrefix IN
    /// ["/my-log-prod"]`
    /// or `LogGroupNamePrefix IN ["/my-logging"]`, as the set of log groups
    /// matching these
    /// prefixes would be a subset of the log groups matching the first policy's
    /// prefix, creating an
    /// overlap.
    ///
    /// When using `NOT IN`, only one policy with this operator is allowed per
    /// account.
    ///
    /// When combining policies with `IN` and `NOT IN` operators, the
    /// overlap check ensures that policies don't have conflicting effects. Two
    /// policies with
    /// `IN` and `NOT IN` operators do not overlap if and only if every value
    /// in the `IN `policy is completely contained within some value in the `NOT
    /// IN` policy. For example:
    ///
    /// * If you have a `NOT IN` policy for prefix `"/aws/lambda"`, you
    /// can create an `IN` policy for the exact log group name
    /// `"/aws/lambda/function1"` because the set of log groups matching
    /// `"/aws/lambda/function1"` is a subset of the log groups matching
    /// `"/aws/lambda"`.
    ///
    /// * If you have a `NOT IN` policy for prefix `"/aws/lambda"`, you
    /// cannot create an `IN` policy for prefix `"/aws"` because the set of
    /// log groups matching `"/aws"` is not a subset of the log groups matching
    /// `"/aws/lambda"`.
    pub fn putAccountPolicy(self: *Self, allocator: std.mem.Allocator, input: put_account_policy.PutAccountPolicyInput, options: CallOptions) !put_account_policy.PutAccountPolicyOutput {
        return put_account_policy.execute(self, allocator, input, options);
    }

    /// Creates a data protection policy for the specified log group. A data
    /// protection policy can
    /// help safeguard sensitive data that's ingested by the log group by auditing
    /// and masking the
    /// sensitive log data.
    ///
    /// Sensitive data is detected and masked when it is ingested into the log
    /// group. When you
    /// set a data protection policy, log events ingested into the log group before
    /// that time are
    /// not masked.
    ///
    /// By default, when a user views a log event that includes masked data, the
    /// sensitive data is
    /// replaced by asterisks. A user who has the `logs:Unmask` permission can use a
    /// [GetLogEvents](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_GetLogEvents.html) or [FilterLogEvents](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_FilterLogEvents.html) operation with the `unmask` parameter set to
    /// `true` to view the unmasked log events. Users with the `logs:Unmask`
    /// can also view unmasked data in the CloudWatch Logs console by running a
    /// CloudWatch Logs
    /// Insights query with the `unmask` query command.
    ///
    /// For more information, including a list of types of data that can be audited
    /// and masked,
    /// see [Protect sensitive log data
    /// with
    /// masking](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/mask-sensitive-log-data.html).
    ///
    /// The `PutDataProtectionPolicy` operation applies to only the specified log
    /// group. You can also use
    /// [PutAccountPolicy](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_PutAccountPolicy.html) to create an account-level data protection policy that applies to
    /// all log groups in the account, including both existing log groups and log
    /// groups that are
    /// created level. If a log group has its own data protection policy and the
    /// account also has an
    /// account-level data protection policy, then the two policies are cumulative.
    /// Any sensitive term
    /// specified in either policy is masked.
    pub fn putDataProtectionPolicy(self: *Self, allocator: std.mem.Allocator, input: put_data_protection_policy.PutDataProtectionPolicyInput, options: CallOptions) !put_data_protection_policy.PutDataProtectionPolicyOutput {
        return put_data_protection_policy.execute(self, allocator, input, options);
    }

    /// Creates or updates a logical *delivery destination*. A delivery
    /// destination is an Amazon Web Services resource that represents an Amazon Web
    /// Services service
    /// that logs can be sent to. CloudWatch Logs, Amazon S3, and Firehose are
    /// supported as logs delivery destinations and X-Ray as the trace delivery
    /// destination.
    ///
    /// To configure logs delivery between a supported Amazon Web Services service
    /// and a
    /// destination, you must do the following:
    ///
    /// * Create a delivery source, which is a logical object that represents the
    ///   resource that
    /// is actually sending the logs. For more information, see
    /// [PutDeliverySource](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_PutDeliverySource.html).
    ///
    /// * Use `PutDeliveryDestination` to create a *delivery
    /// destination* in the same account of the actual delivery destination. The
    /// delivery destination that you create is a logical object that represents the
    /// actual
    /// delivery destination.
    ///
    /// * If you are delivering logs cross-account, you must use
    ///   [PutDeliveryDestinationPolicy](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_PutDeliveryDestinationPolicy.html) in the destination account to assign an IAM policy to the destination. This policy allows delivery to that destination.
    ///
    /// * Use `CreateDelivery` to create a *delivery* by pairing
    /// exactly one delivery source and one delivery destination. For more
    /// information, see
    /// [CreateDelivery](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_CreateDelivery.html).
    ///
    /// You can configure a single delivery source to send logs to multiple
    /// destinations by
    /// creating multiple deliveries. You can also create multiple deliveries to
    /// configure multiple
    /// delivery sources to send logs to the same delivery destination.
    ///
    /// Only some Amazon Web Services services support being configured as a
    /// delivery source. These
    /// services are listed as **Supported [V2 Permissions]** in the
    /// table at [Enabling logging from
    /// Amazon Web Services
    /// services.](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/AWS-logs-and-resource-policy.html)
    ///
    /// If you use this operation to update an existing delivery destination, all
    /// the current
    /// delivery destination parameters are overwritten with the new parameter
    /// values that you
    /// specify.
    pub fn putDeliveryDestination(self: *Self, allocator: std.mem.Allocator, input: put_delivery_destination.PutDeliveryDestinationInput, options: CallOptions) !put_delivery_destination.PutDeliveryDestinationOutput {
        return put_delivery_destination.execute(self, allocator, input, options);
    }

    /// Creates and assigns an IAM policy that grants permissions to CloudWatch Logs
    /// to deliver logs cross-account to a specified destination in this account. To
    /// configure the delivery of logs from an Amazon Web Services service in
    /// another account to a logs
    /// delivery destination in the current account, you must do the following:
    ///
    /// * Create a delivery source, which is a logical object that represents the
    ///   resource that
    /// is actually sending the logs. For more information, see
    /// [PutDeliverySource](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_PutDeliverySource.html).
    ///
    /// * Create a *delivery destination*, which is a logical object that
    /// represents the actual delivery destination. For more information, see
    /// [PutDeliveryDestination](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_PutDeliveryDestination.html).
    ///
    /// * Use this operation in the destination account to assign an IAM policy
    /// to the destination. This policy allows delivery to that destination.
    ///
    /// * Create a *delivery* by pairing exactly one delivery source and one
    /// delivery destination. For more information, see
    /// [CreateDelivery](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_CreateDelivery.html).
    ///
    /// Only some Amazon Web Services services support being configured as a
    /// delivery source. These
    /// services are listed as **Supported [V2 Permissions]** in the
    /// table at [Enabling logging from
    /// Amazon Web Services
    /// services.](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/AWS-logs-and-resource-policy.html)
    ///
    /// The contents of the policy must include two statements. One statement
    /// enables general logs
    /// delivery, and the other allows delivery to the chosen destination. See the
    /// examples for the
    /// needed policies.
    pub fn putDeliveryDestinationPolicy(self: *Self, allocator: std.mem.Allocator, input: put_delivery_destination_policy.PutDeliveryDestinationPolicyInput, options: CallOptions) !put_delivery_destination_policy.PutDeliveryDestinationPolicyOutput {
        return put_delivery_destination_policy.execute(self, allocator, input, options);
    }

    /// Creates or updates a logical *delivery source*. A delivery source
    /// represents an Amazon Web Services resource that sends logs to an logs
    /// delivery destination. The
    /// destination can be CloudWatch Logs, Amazon S3, Firehose or X-Ray for sending
    /// traces.
    ///
    /// To configure logs delivery between a delivery destination and an Amazon Web
    /// Services
    /// service that is supported as a delivery source, you must do the following:
    ///
    /// * Use `PutDeliverySource` to create a delivery source, which is a logical
    /// object that represents the resource that is actually sending the logs.
    ///
    /// * Use `PutDeliveryDestination` to create a *delivery
    /// destination*, which is a logical object that represents the actual delivery
    /// destination. For more information, see
    /// [PutDeliveryDestination](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_PutDeliveryDestination.html).
    ///
    /// * If you are delivering logs cross-account, you must use
    ///   [PutDeliveryDestinationPolicy](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_PutDeliveryDestinationPolicy.html) in the destination account to assign an IAM policy to the destination. This policy allows delivery to that destination.
    ///
    /// * Use `CreateDelivery` to create a *delivery* by pairing
    /// exactly one delivery source and one delivery destination. For more
    /// information, see
    /// [CreateDelivery](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_CreateDelivery.html).
    ///
    /// You can configure a single delivery source to send logs to multiple
    /// destinations by
    /// creating multiple deliveries. You can also create multiple deliveries to
    /// configure multiple
    /// delivery sources to send logs to the same delivery destination.
    ///
    /// Only some Amazon Web Services services support being configured as a
    /// delivery source. These
    /// services are listed as **Supported [V2 Permissions]** in the
    /// table at [Enabling logging from
    /// Amazon Web Services
    /// services.](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/AWS-logs-and-resource-policy.html)
    ///
    /// If you use this operation to update an existing delivery source, all the
    /// current delivery
    /// source parameters are overwritten with the new parameter values that you
    /// specify.
    pub fn putDeliverySource(self: *Self, allocator: std.mem.Allocator, input: put_delivery_source.PutDeliverySourceInput, options: CallOptions) !put_delivery_source.PutDeliverySourceOutput {
        return put_delivery_source.execute(self, allocator, input, options);
    }

    /// Creates or updates a destination. This operation is used only to create
    /// destinations
    /// for cross-account subscriptions.
    ///
    /// A destination encapsulates a physical resource (such as an Amazon Kinesis
    /// stream). With
    /// a destination, you can subscribe to a real-time stream of log events for a
    /// different account,
    /// ingested using
    /// [PutLogEvents](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_PutLogEvents.html).
    ///
    /// Through an access policy, a destination controls what is written to it. By
    /// default,
    /// `PutDestination` does not set any access policy with the destination, which
    /// means
    /// a cross-account user cannot call
    /// [PutSubscriptionFilter](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_PutSubscriptionFilter.html) against this destination. To enable this, the destination
    /// owner must call
    /// [PutDestinationPolicy](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_PutDestinationPolicy.html) after `PutDestination`.
    ///
    /// To perform a `PutDestination` operation, you must also have the
    /// `iam:PassRole` permission.
    pub fn putDestination(self: *Self, allocator: std.mem.Allocator, input: put_destination.PutDestinationInput, options: CallOptions) !put_destination.PutDestinationOutput {
        return put_destination.execute(self, allocator, input, options);
    }

    /// Creates or updates an access policy associated with an existing destination.
    /// An access
    /// policy is an [IAM
    /// policy
    /// document](https://docs.aws.amazon.com/IAM/latest/UserGuide/policies_overview.html) that is used to authorize claims to register a subscription filter
    /// against a given destination.
    pub fn putDestinationPolicy(self: *Self, allocator: std.mem.Allocator, input: put_destination_policy.PutDestinationPolicyInput, options: CallOptions) !put_destination_policy.PutDestinationPolicyOutput {
        return put_destination_policy.execute(self, allocator, input, options);
    }

    /// Creates or updates a *field index policy* for the specified log group.
    /// Only log groups in the Standard log class support field index policies. For
    /// more information
    /// about log classes, see [Log
    /// classes](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch_Logs_Log_Classes.html).
    ///
    /// You can use field index policies to create *field indexes* on fields
    /// found in log events in the log group. Creating field indexes speeds up and
    /// lowers the costs
    /// for CloudWatch Logs Insights queries that reference those field indexes,
    /// because these
    /// queries attempt to skip the processing of log events that are known to not
    /// match the indexed
    /// field. Good fields to index are fields that you often need to query for and
    /// fields or values
    /// that match only a small fraction of the total log events. Common examples of
    /// indexes include
    /// request ID, session ID, userID, and instance IDs. For more information, see
    /// [Create field indexes to improve query performance and reduce
    /// costs](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatchLogs-Field-Indexing.html).
    ///
    /// You can configure indexed fields as *facets* to enable interactive
    /// exploration and filtering of your logs in the CloudWatch Logs Insights
    /// console. Facets
    /// allow you to view value distributions and counts for indexed fields without
    /// running queries.
    /// When you create a field index, you can optionally set it as a facet to
    /// enable this interactive
    /// analysis capability. For more information, see [Use facets to group and
    /// explore
    /// logs](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatchLogs-Facets.html).
    ///
    /// To find the fields that are in your log group events, use the
    /// [GetLogGroupFields](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_GetLogGroupFields.html) operation.
    ///
    /// For example, suppose you have created a field index for `requestId`. Then,
    /// any
    /// CloudWatch Logs Insights query on that log group that includes `requestId =
    /// *value*
    /// ` or `requestId IN [*value*,
    /// *value*, ...]` will process fewer log events to reduce costs, and
    /// have improved performance.
    ///
    /// CloudWatch Logs provides default field indexes for all log groups in the
    /// Standard log
    /// class. Default field indexes are automatically available for the following
    /// fields:
    ///
    /// * `@logStream`
    ///
    /// * `@aws.region`
    ///
    /// * `@aws.account`
    ///
    /// * `@source.log`
    ///
    /// * `traceId`
    ///
    /// Default field indexes are in addition to any custom field indexes you define
    /// within your
    /// policy. Default field indexes are not counted towards your field index
    /// quota.
    ///
    /// Each index policy has the following quotas and restrictions:
    ///
    /// * As many as 20 fields can be included in the policy.
    ///
    /// * Each field name can include as many as 100 characters.
    ///
    /// Matches of log events to the names of indexed fields are case-sensitive. For
    /// example, a
    /// field index of `RequestId` won't match a log event containing
    /// `requestId`.
    ///
    /// Log group-level field index policies created with `PutIndexPolicy` override
    /// account-level field index policies created with
    /// [PutAccountPolicy](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_PutAccountPolicy.html) that apply to log groups. If you use `PutIndexPolicy`
    /// to create a field index policy for a log group, that log group uses only
    /// that policy for log
    /// group-level indexing, including any facet configurations. The log group
    /// ignores any
    /// account-wide field index policy that applies to log groups, but data
    /// source-based account
    /// policies may still apply.
    pub fn putIndexPolicy(self: *Self, allocator: std.mem.Allocator, input: put_index_policy.PutIndexPolicyInput, options: CallOptions) !put_index_policy.PutIndexPolicyOutput {
        return put_index_policy.execute(self, allocator, input, options);
    }

    /// Creates an integration between CloudWatch Logs and another service in this
    /// account.
    /// Currently, only integrations with OpenSearch Service are supported, and
    /// currently you can have
    /// only one integration in your account.
    ///
    /// Integrating with OpenSearch Service makes it possible for you to create
    /// curated vended
    /// logs dashboards, powered by OpenSearch Service analytics. For more
    /// information, see [Vended log
    /// dashboards powered by Amazon OpenSearch
    /// Service](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatchLogs-OpenSearch-Dashboards.html).
    ///
    /// You can use this operation only to create a new integration. You can't
    /// modify an existing
    /// integration.
    pub fn putIntegration(self: *Self, allocator: std.mem.Allocator, input: put_integration.PutIntegrationInput, options: CallOptions) !put_integration.PutIntegrationOutput {
        return put_integration.execute(self, allocator, input, options);
    }

    /// Uploads a batch of log events to the specified log stream.
    ///
    /// The sequence token is now ignored in `PutLogEvents` actions.
    /// `PutLogEvents` actions are always accepted and never return
    /// `InvalidSequenceTokenException` or `DataAlreadyAcceptedException`
    /// even if the sequence token is not valid. You can use parallel `PutLogEvents`
    /// actions on the same log stream.
    ///
    /// The batch of events must satisfy the following constraints:
    ///
    /// * The maximum batch size is 1,048,576 bytes. This size is calculated as the
    ///   sum of
    /// all event messages in UTF-8, plus 26 bytes for each log event.
    ///
    /// * Events more than 2 hours in the future are rejected while processing
    ///   remaining
    /// valid events.
    ///
    /// * Events older than 14 days or preceding the log group's retention period
    ///   are
    /// rejected while processing remaining valid events.
    ///
    /// * The log events in the batch must be in chronological order by their
    ///   timestamp. The
    /// timestamp is the time that the event occurred, expressed as the number of
    /// milliseconds
    /// after `Jan 1, 1970 00:00:00 UTC`. (In Amazon Web Services Tools for
    /// PowerShell
    /// and the Amazon Web Services SDK for .NET, the timestamp is specified in .NET
    /// format:
    /// `yyyy-mm-ddThh:mm:ss`. For example, `2017-09-15T13:45:30`.)
    ///
    /// * A batch of log events in a single request must be in a chronological
    ///   order.
    /// Otherwise, the operation fails.
    ///
    /// * Each log event can be no larger than 1 MB.
    ///
    /// * The maximum number of log events in a batch is 10,000.
    ///
    /// * For valid events (within 14 days in the past to 2 hours in future), the
    ///   time span
    /// in a single batch cannot exceed 24 hours. Otherwise, the operation fails.
    ///
    /// The quota of five requests per second per log stream has been removed.
    /// Instead,
    /// `PutLogEvents` actions are throttled based on a per-second per-account
    /// quota.
    /// You can request an increase to the per-second throttling quota by using the
    /// Service Quotas service.
    ///
    /// If a call to `PutLogEvents` returns "UnrecognizedClientException" the most
    /// likely cause is a non-valid Amazon Web Services access key ID or secret key.
    pub fn putLogEvents(self: *Self, allocator: std.mem.Allocator, input: put_log_events.PutLogEventsInput, options: CallOptions) !put_log_events.PutLogEventsOutput {
        return put_log_events.execute(self, allocator, input, options);
    }

    /// Enables or disables deletion protection for the specified log group. When
    /// enabled on a
    /// log group, deletion protection blocks all deletion operations until it is
    /// explicitly
    /// disabled.
    ///
    /// For information about the parameters that are common to all actions, see
    /// [Common
    /// Parameters](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/CommonParameters.html).
    pub fn putLogGroupDeletionProtection(self: *Self, allocator: std.mem.Allocator, input: put_log_group_deletion_protection.PutLogGroupDeletionProtectionInput, options: CallOptions) !put_log_group_deletion_protection.PutLogGroupDeletionProtectionOutput {
        return put_log_group_deletion_protection.execute(self, allocator, input, options);
    }

    /// Creates or updates a metric filter and associates it with the specified log
    /// group. With
    /// metric filters, you can configure rules to extract metric data from log
    /// events ingested
    /// through
    /// [PutLogEvents](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_PutLogEvents.html).
    ///
    /// The maximum number of metric filters that can be associated with a log group
    /// is
    /// 100.
    ///
    /// Using regular expressions in filter patterns is supported. For these
    /// filters, there is a
    /// quota of two regular expression patterns within a single filter pattern.
    /// There is also a quota
    /// of five regular expression patterns per log group. For more information
    /// about using regular
    /// expressions in filter patterns, see [ Filter pattern syntax for
    /// metric filters, subscription filters, filter log events, and Live
    /// Tail](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/FilterAndPatternSyntax.html).
    ///
    /// When you create a metric filter, you can also optionally assign a unit and
    /// dimensions to
    /// the metric that is created.
    ///
    /// Metrics extracted from log events are charged as custom metrics. To prevent
    /// unexpected
    /// high charges, do not specify high-cardinality fields such as `IPAddress` or
    /// `requestID` as dimensions. Each different value found for a dimension is
    /// treated as a separate metric and accrues charges as a separate custom
    /// metric.
    ///
    /// CloudWatch Logs might disable a metric filter if it generates 1,000
    /// different
    /// name/value pairs for your specified dimensions within one hour.
    ///
    /// You can also set up a billing alarm to alert you if your charges are higher
    /// than
    /// expected. For more information, see [
    /// Creating a Billing Alarm to Monitor Your Estimated Amazon Web Services
    /// Charges](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/monitor_estimated_charges_with_cloudwatch.html).
    pub fn putMetricFilter(self: *Self, allocator: std.mem.Allocator, input: put_metric_filter.PutMetricFilterInput, options: CallOptions) !put_metric_filter.PutMetricFilterOutput {
        return put_metric_filter.execute(self, allocator, input, options);
    }

    /// Creates or updates a query definition for CloudWatch Logs Insights. For more
    /// information,
    /// see [Analyzing Log Data with CloudWatch Logs
    /// Insights](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/AnalyzingLogData.html).
    ///
    /// To update a query definition, specify its `queryDefinitionId` in your
    /// request.
    /// The values of `name`, `queryString`, and `logGroupNames` are
    /// changed to the values that you specify in your update operation. No current
    /// values are
    /// retained from the current query definition. For example, imagine updating a
    /// current query
    /// definition that includes log groups. If you don't specify the
    /// `logGroupNames`
    /// parameter in your update operation, the query definition changes to contain
    /// no log
    /// groups.
    ///
    /// You must have the `logs:PutQueryDefinition` permission to be able to perform
    /// this operation.
    pub fn putQueryDefinition(self: *Self, allocator: std.mem.Allocator, input: put_query_definition.PutQueryDefinitionInput, options: CallOptions) !put_query_definition.PutQueryDefinitionOutput {
        return put_query_definition.execute(self, allocator, input, options);
    }

    /// Creates or updates a resource policy allowing other Amazon Web Services
    /// services to put
    /// log events to this account, such as Amazon Route 53. This API has the
    /// following
    /// restrictions:
    ///
    /// * **Supported actions** - Policy only supports
    /// `logs:PutLogEvents` and `logs:CreateLogStream ` actions
    ///
    /// * **Supported principals** - Policy only applies when
    /// operations are invoked by Amazon Web Services service principals (not IAM
    /// users, roles, or cross-account principals
    ///
    /// * **Policy limits** - An account can have a maximum of 10
    /// policies without resourceARN and one per LogGroup resourceARN
    ///
    /// Resource policies with actions invoked by non-Amazon Web Services service
    /// principals
    /// (such as IAM users, roles, or other Amazon Web Services accounts) will not
    /// be
    /// enforced. For access control involving these principals, use the IAM
    /// policies.
    pub fn putResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: put_resource_policy.PutResourcePolicyInput, options: CallOptions) !put_resource_policy.PutResourcePolicyOutput {
        return put_resource_policy.execute(self, allocator, input, options);
    }

    /// Sets the retention of the specified log group. With a retention policy, you
    /// can
    /// configure the number of days for which to retain log events in the specified
    /// log
    /// group.
    ///
    /// CloudWatch Logs doesn't immediately delete log events when they reach their
    /// retention
    /// setting. It typically takes up to 72 hours after that before log events are
    /// deleted, but in
    /// rare situations might take longer.
    ///
    /// To illustrate, imagine that you change a log group to have a longer
    /// retention setting
    /// when it contains log events that are past the expiration date, but haven't
    /// been deleted.
    /// Those log events will take up to 72 hours to be deleted after the new
    /// retention date is
    /// reached. To make sure that log data is deleted permanently, keep a log group
    /// at its lower
    /// retention setting until 72 hours after the previous retention period ends.
    /// Alternatively,
    /// wait to change the retention setting until you confirm that the earlier log
    /// events are
    /// deleted.
    ///
    /// When log events reach their retention setting they are marked for deletion.
    /// After they
    /// are marked for deletion, they do not add to your archival storage costs
    /// anymore, even if
    /// they are not actually deleted until later. These log events marked for
    /// deletion are also not
    /// included when you use an API to retrieve the `storedBytes` value to see how
    /// many
    /// bytes a log group is storing.
    pub fn putRetentionPolicy(self: *Self, allocator: std.mem.Allocator, input: put_retention_policy.PutRetentionPolicyInput, options: CallOptions) !put_retention_policy.PutRetentionPolicyOutput {
        return put_retention_policy.execute(self, allocator, input, options);
    }

    /// Creates or updates a subscription filter and associates it with the
    /// specified log
    /// group. With subscription filters, you can subscribe to a real-time stream of
    /// log events
    /// ingested through
    /// [PutLogEvents](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_PutLogEvents.html)
    /// and have them delivered to a specific destination. When log events are sent
    /// to the receiving
    /// service, they are Base64 encoded and compressed with the GZIP format.
    ///
    /// The following destinations are supported for subscription filters:
    ///
    /// * An Amazon Kinesis data stream belonging to the same account as the
    ///   subscription
    /// filter, for same-account delivery.
    ///
    /// * A logical destination created with
    ///   [PutDestination](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_PutDestination.html) that belongs to a different account, for cross-account delivery.
    /// We currently support Kinesis Data Streams and Firehose as logical
    /// destinations.
    ///
    /// * An Amazon Kinesis Data Firehose delivery stream that belongs to the same
    ///   account as
    /// the subscription filter, for same-account delivery.
    ///
    /// * An Lambda function that belongs to the same account as the
    /// subscription filter, for same-account delivery.
    ///
    /// Each log group can have up to two subscription filters associated with it.
    /// If you are
    /// updating an existing filter, you must specify the correct name in
    /// `filterName`.
    ///
    /// Using regular expressions in filter patterns is supported. For these
    /// filters, there is a
    /// quotas of quota of two regular expression patterns within a single filter
    /// pattern. There is
    /// also a quota of five regular expression patterns per log group. For more
    /// information about
    /// using regular expressions in filter patterns, see [ Filter pattern syntax
    /// for
    /// metric filters, subscription filters, filter log events, and Live
    /// Tail](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/FilterAndPatternSyntax.html).
    ///
    /// To perform a `PutSubscriptionFilter` operation for any destination except a
    /// Lambda function, you must also have the `iam:PassRole`
    /// permission.
    pub fn putSubscriptionFilter(self: *Self, allocator: std.mem.Allocator, input: put_subscription_filter.PutSubscriptionFilterInput, options: CallOptions) !put_subscription_filter.PutSubscriptionFilterOutput {
        return put_subscription_filter.execute(self, allocator, input, options);
    }

    /// Creates or updates a *log transformer* for a single log group. You use
    /// log transformers to transform log events into a different format, making
    /// them easier for you
    /// to process and analyze. You can also transform logs from different sources
    /// into standardized
    /// formats that contains relevant, source-specific information.
    ///
    /// After you have created a transformer, CloudWatch Logs performs the
    /// transformations at
    /// the time of log ingestion. You can then refer to the transformed versions of
    /// the logs during
    /// operations such as querying with CloudWatch Logs Insights or creating metric
    /// filters or
    /// subscription filers.
    ///
    /// You can also use a transformer to copy metadata from metadata keys into the
    /// log events
    /// themselves. This metadata can include log group name, log stream name,
    /// account ID and
    /// Region.
    ///
    /// A transformer for a log group is a series of processors, where each
    /// processor applies one
    /// type of transformation to the log events ingested into this log group. The
    /// processors work one
    /// after another, in the order that you list them, like a pipeline. For more
    /// information about
    /// the available processors to use in a transformer, see [ Processors that you
    /// can
    /// use](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-Processors).
    ///
    /// Having log events in standardized format enables visibility across your
    /// applications for
    /// your log analysis, reporting, and alarming needs. CloudWatch Logs provides
    /// transformation
    /// for common log types with out-of-the-box transformation templates for major
    /// Amazon Web Services
    /// log sources such as VPC flow logs, Lambda, and Amazon RDS. You can use
    /// pre-built transformation templates or create custom transformation policies.
    ///
    /// You can create transformers only for the log groups in the Standard log
    /// class.
    ///
    /// You can also set up a transformer at the account level. For more
    /// information, see
    /// [PutAccountPolicy](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_PutAccountPolicy.html). If there is both a log-group level transformer created with
    /// `PutTransformer` and an account-level transformer that could apply to the
    /// same
    /// log group, the log group uses only the log-group level transformer. It
    /// ignores the
    /// account-level transformer.
    pub fn putTransformer(self: *Self, allocator: std.mem.Allocator, input: put_transformer.PutTransformerInput, options: CallOptions) !put_transformer.PutTransformerOutput {
        return put_transformer.execute(self, allocator, input, options);
    }

    /// Starts a Live Tail streaming session for one or more log groups. A Live Tail
    /// session
    /// returns a stream of log events that have been recently ingested in the log
    /// groups. For more
    /// information, see [Use Live Tail to view logs
    /// in near real
    /// time](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatchLogs_LiveTail.html).
    ///
    /// The response to this operation is a response stream, over which the server
    /// sends live log
    /// events and the client receives them.
    ///
    /// The following objects are sent over the stream:
    ///
    /// * A single
    ///   [LiveTailSessionStart](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_LiveTailSessionStart.html) object is sent at the start of the session.
    ///
    /// * Every second, a
    ///   [LiveTailSessionUpdate](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_LiveTailSessionUpdate.html) object is sent. Each of these objects contains an array
    /// of the actual log events.
    ///
    /// If no new log events were ingested in the past second, the
    /// `LiveTailSessionUpdate` object will contain an empty array.
    ///
    /// The array of log events contained in a `LiveTailSessionUpdate` can include
    /// as many as 500 log events. If the number of log events matching the request
    /// exceeds 500
    /// per second, the log events are sampled down to 500 log events to be included
    /// in each
    /// `LiveTailSessionUpdate` object.
    ///
    /// If your client consumes the log events slower than the server produces them,
    /// CloudWatch Logs buffers up to 10 `LiveTailSessionUpdate` events or 5000 log
    /// events, after which it starts dropping the oldest events.
    ///
    /// * A
    ///   [SessionStreamingException](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_StartLiveTailResponseStream.html#CWL-Type-StartLiveTailResponseStream-SessionStreamingException) object is returned if an unknown error occurs on the
    /// server side.
    ///
    /// * A
    ///   [SessionTimeoutException](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_StartLiveTailResponseStream.html#CWL-Type-StartLiveTailResponseStream-SessionTimeoutException) object is returned when the session times out, after it
    /// has been kept open for three hours.
    ///
    /// The `StartLiveTail` API routes requests to
    /// `streaming-logs.*Region*.amazonaws.com` using SDK host
    /// prefix injection. VPC endpoint support is not available for this API.
    ///
    /// You can end a session before it times out by closing the session stream or
    /// by closing
    /// the client that is receiving the stream. The session also ends if the
    /// established connection
    /// between the client and the server breaks.
    ///
    /// For examples of using an SDK to start a Live Tail session, see [ Start
    /// a Live Tail session using an Amazon Web Services
    /// SDK](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/example_cloudwatch-logs_StartLiveTail_section.html).
    pub fn startLiveTail(self: *Self, allocator: std.mem.Allocator, input: start_live_tail.StartLiveTailInput, options: CallOptions) !start_live_tail.StartLiveTailOutput {
        return start_live_tail.execute(self, allocator, input, options);
    }

    /// Starts a query of one or more log groups or data sources using CloudWatch
    /// Logs
    /// Insights. You specify the log groups or data sources and time range to query
    /// and the query
    /// string to use. You can query up to 10 data sources in a single query.
    ///
    /// For more information, see [CloudWatch Logs Insights Query
    /// Syntax](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CWL_QuerySyntax.html).
    ///
    /// After you run a query using `StartQuery`, the query results are stored by
    /// CloudWatch Logs. You can use
    /// [GetQueryResults](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_GetQueryResults.html) to retrieve the results of a query, using the `queryId`
    /// that `StartQuery` returns.
    ///
    /// Interactive queries started with `StartQuery` share concurrency limits with
    /// automated scheduled query executions. Both types of queries count toward the
    /// same regional
    /// concurrent query quota, so high scheduled query activity may affect the
    /// availability of
    /// concurrent slots for interactive queries.
    ///
    /// To specify the log groups to query, a `StartQuery` operation must include
    /// one
    /// of the following:
    ///
    /// * Either exactly one of the following parameters: `logGroupName`,
    /// `logGroupNames`, or `logGroupIdentifiers`
    ///
    /// * Or the `queryString` must include a `SOURCE` command to select
    /// log groups for the query. The `SOURCE` command can select log groups based
    /// on
    /// log group name prefix, account ID, and log class, or select data sources
    /// using
    /// dataSource syntax in LogsQL, PPL, and SQL.
    ///
    /// For more information about the `SOURCE` command, see
    /// [SOURCE](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CWL_QuerySyntax-Source.html).
    ///
    /// If you have associated a KMS key with the query results in this
    /// account, then
    /// [StartQuery](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_StartQuery.html) uses
    /// that key to encrypt the results when it stores them. If no key is associated
    /// with query
    /// results, the query results are encrypted with the default CloudWatch Logs
    /// encryption
    /// method.
    ///
    /// Queries time out after 60 minutes of runtime. If your queries are timing
    /// out, reduce the
    /// time range being searched or partition your query into a number of queries.
    ///
    /// If you are using CloudWatch cross-account observability, you can use this
    /// operation
    /// in a monitoring account to start a query in a linked source account. For
    /// more information, see
    /// [CloudWatch cross-account
    /// observability](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-Unified-Cross-Account.html). For a cross-account `StartQuery`
    /// operation, the query definition must be defined in the monitoring account.
    ///
    /// You can have up to 30 concurrent CloudWatch Logs insights queries, including
    /// queries
    /// that have been added to dashboards.
    pub fn startQuery(self: *Self, allocator: std.mem.Allocator, input: start_query.StartQueryInput, options: CallOptions) !start_query.StartQueryOutput {
        return start_query.execute(self, allocator, input, options);
    }

    /// Stops a CloudWatch Logs Insights query that is in progress. If the query has
    /// already
    /// ended, the operation returns an error indicating that the specified query is
    /// not
    /// running.
    ///
    /// This operation can be used to cancel both interactive queries and individual
    /// scheduled
    /// query executions. When used with scheduled queries, `StopQuery` cancels only
    /// the
    /// specific execution identified by the query ID, not the scheduled query
    /// configuration
    /// itself.
    pub fn stopQuery(self: *Self, allocator: std.mem.Allocator, input: stop_query.StopQueryInput, options: CallOptions) !stop_query.StopQueryOutput {
        return stop_query.execute(self, allocator, input, options);
    }

    /// The TagLogGroup operation is on the path to deprecation. We recommend that
    /// you use
    /// [TagResource](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_TagResource.html)
    /// instead.
    ///
    /// Adds or updates the specified tags for the specified log group.
    ///
    /// To list the tags for a log group, use
    /// [ListTagsForResource](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_ListTagsForResource.html). To remove tags, use [UntagResource](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_UntagResource.html).
    ///
    /// For more information about tags, see [Tag Log Groups in Amazon CloudWatch
    /// Logs](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/Working-with-log-groups-and-streams.html#log-group-tagging) in the *Amazon CloudWatch Logs
    /// User Guide*.
    ///
    /// CloudWatch Logs doesn't support IAM policies that prevent users from
    /// assigning specified
    /// tags to log groups using the `aws:Resource/*key-name*
    /// ` or
    /// `aws:TagKeys` condition keys. For more information about using tags to
    /// control
    /// access, see [Controlling access to Amazon Web Services resources using
    /// tags](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_tags.html).
    pub fn tagLogGroup(self: *Self, allocator: std.mem.Allocator, input: tag_log_group.TagLogGroupInput, options: CallOptions) !tag_log_group.TagLogGroupOutput {
        return tag_log_group.execute(self, allocator, input, options);
    }

    /// Assigns one or more tags (key-value pairs) to the specified CloudWatch Logs
    /// resource.
    /// Currently, the only CloudWatch Logs resources that can be tagged are log
    /// groups and
    /// destinations.
    ///
    /// Tags can help you organize and categorize your resources. You can also use
    /// them to scope
    /// user permissions by granting a user permission to access or change only
    /// resources with certain
    /// tag values.
    ///
    /// Tags don't have any semantic meaning to Amazon Web Services and are
    /// interpreted strictly as
    /// strings of characters.
    ///
    /// You can use the `TagResource` action with a resource that already has tags.
    /// If
    /// you specify a new tag key for the alarm, this tag is appended to the list of
    /// tags associated
    /// with the alarm. If you specify a tag key that is already associated with the
    /// alarm, the new
    /// tag value that you specify replaces the previous value for that tag.
    ///
    /// You can associate as many as 50 tags with a CloudWatch Logs resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Tests the filter pattern of a metric filter against a sample of log event
    /// messages. You
    /// can use this operation to validate the correctness of a metric filter
    /// pattern.
    pub fn testMetricFilter(self: *Self, allocator: std.mem.Allocator, input: test_metric_filter.TestMetricFilterInput, options: CallOptions) !test_metric_filter.TestMetricFilterOutput {
        return test_metric_filter.execute(self, allocator, input, options);
    }

    /// Use this operation to test a log transformer. You enter the transformer
    /// configuration and
    /// a set of log events to test with. The operation responds with an array that
    /// includes the
    /// original log events and the transformed versions.
    pub fn testTransformer(self: *Self, allocator: std.mem.Allocator, input: test_transformer.TestTransformerInput, options: CallOptions) !test_transformer.TestTransformerOutput {
        return test_transformer.execute(self, allocator, input, options);
    }

    /// The UntagLogGroup operation is on the path to deprecation. We recommend that
    /// you use
    /// [UntagResource](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_UntagResource.html) instead.
    ///
    /// Removes the specified tags from the specified log group.
    ///
    /// To list the tags for a log group, use
    /// [ListTagsForResource](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_ListTagsForResource.html). To add tags, use [TagResource](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_TagResource.html).
    ///
    /// When using IAM policies to control tag management for CloudWatch Logs log
    /// groups, the
    /// condition keys `aws:Resource/key-name` and `aws:TagKeys` cannot be used
    /// to restrict which tags users can assign.
    pub fn untagLogGroup(self: *Self, allocator: std.mem.Allocator, input: untag_log_group.UntagLogGroupInput, options: CallOptions) !untag_log_group.UntagLogGroupOutput {
        return untag_log_group.execute(self, allocator, input, options);
    }

    /// Removes one or more tags from the specified resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Use this operation to *suppress* anomaly detection for a specified
    /// anomaly or pattern. If you suppress an anomaly, CloudWatch Logs won't report
    /// new
    /// occurrences of that anomaly and won't update that anomaly with new data. If
    /// you suppress a
    /// pattern, CloudWatch Logs won't report any anomalies related to that pattern.
    ///
    /// You must specify either `anomalyId` or `patternId`, but you can't
    /// specify both parameters in the same operation.
    ///
    /// If you have previously used this operation to suppress detection of a
    /// pattern or anomaly,
    /// you can use it again to cause CloudWatch Logs to end the suppression. To do
    /// this, use this
    /// operation and specify the anomaly or pattern to stop suppressing, and omit
    /// the
    /// `suppressionType` and `suppressionPeriod` parameters.
    pub fn updateAnomaly(self: *Self, allocator: std.mem.Allocator, input: update_anomaly.UpdateAnomalyInput, options: CallOptions) !update_anomaly.UpdateAnomalyOutput {
        return update_anomaly.execute(self, allocator, input, options);
    }

    /// Use this operation to update the configuration of a
    /// [delivery](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_Delivery.html) to change
    /// either the S3 path pattern or the format of the delivered logs. You can't
    /// use this operation
    /// to change the source or destination of the delivery.
    pub fn updateDeliveryConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_delivery_configuration.UpdateDeliveryConfigurationInput, options: CallOptions) !update_delivery_configuration.UpdateDeliveryConfigurationOutput {
        return update_delivery_configuration.execute(self, allocator, input, options);
    }

    /// Updates an existing log anomaly detector.
    pub fn updateLogAnomalyDetector(self: *Self, allocator: std.mem.Allocator, input: update_log_anomaly_detector.UpdateLogAnomalyDetectorInput, options: CallOptions) !update_log_anomaly_detector.UpdateLogAnomalyDetectorOutput {
        return update_log_anomaly_detector.execute(self, allocator, input, options);
    }

    /// Updates an existing scheduled query with new configuration. This operation
    /// uses PUT
    /// semantics, allowing modification of query parameters, schedule, and
    /// destinations.
    pub fn updateScheduledQuery(self: *Self, allocator: std.mem.Allocator, input: update_scheduled_query.UpdateScheduledQueryInput, options: CallOptions) !update_scheduled_query.UpdateScheduledQueryOutput {
        return update_scheduled_query.execute(self, allocator, input, options);
    }

    pub fn describeConfigurationTemplatesPaginator(self: *Self, params: describe_configuration_templates.DescribeConfigurationTemplatesInput) paginator.DescribeConfigurationTemplatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeDeliveriesPaginator(self: *Self, params: describe_deliveries.DescribeDeliveriesInput) paginator.DescribeDeliveriesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeDeliveryDestinationsPaginator(self: *Self, params: describe_delivery_destinations.DescribeDeliveryDestinationsInput) paginator.DescribeDeliveryDestinationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeDeliverySourcesPaginator(self: *Self, params: describe_delivery_sources.DescribeDeliverySourcesInput) paginator.DescribeDeliverySourcesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeDestinationsPaginator(self: *Self, params: describe_destinations.DescribeDestinationsInput) paginator.DescribeDestinationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeLogGroupsPaginator(self: *Self, params: describe_log_groups.DescribeLogGroupsInput) paginator.DescribeLogGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeLogStreamsPaginator(self: *Self, params: describe_log_streams.DescribeLogStreamsInput) paginator.DescribeLogStreamsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeMetricFiltersPaginator(self: *Self, params: describe_metric_filters.DescribeMetricFiltersInput) paginator.DescribeMetricFiltersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeSubscriptionFiltersPaginator(self: *Self, params: describe_subscription_filters.DescribeSubscriptionFiltersInput) paginator.DescribeSubscriptionFiltersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn filterLogEventsPaginator(self: *Self, params: filter_log_events.FilterLogEventsInput) paginator.FilterLogEventsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getLogEventsPaginator(self: *Self, params: get_log_events.GetLogEventsInput) paginator.GetLogEventsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getScheduledQueryHistoryPaginator(self: *Self, params: get_scheduled_query_history.GetScheduledQueryHistoryInput) paginator.GetScheduledQueryHistoryPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAggregateLogGroupSummariesPaginator(self: *Self, params: list_aggregate_log_group_summaries.ListAggregateLogGroupSummariesInput) paginator.ListAggregateLogGroupSummariesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAnomaliesPaginator(self: *Self, params: list_anomalies.ListAnomaliesInput) paginator.ListAnomaliesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listLogAnomalyDetectorsPaginator(self: *Self, params: list_log_anomaly_detectors.ListLogAnomalyDetectorsInput) paginator.ListLogAnomalyDetectorsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listLogGroupsForQueryPaginator(self: *Self, params: list_log_groups_for_query.ListLogGroupsForQueryInput) paginator.ListLogGroupsForQueryPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listScheduledQueriesPaginator(self: *Self, params: list_scheduled_queries.ListScheduledQueriesInput) paginator.ListScheduledQueriesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSourcesForS3TableIntegrationPaginator(self: *Self, params: list_sources_for_s3_table_integration.ListSourcesForS3TableIntegrationInput) paginator.ListSourcesForS3TableIntegrationPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
