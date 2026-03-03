const aws = @import("aws");
const std = @import("std");

const create_delivery_stream = @import("create_delivery_stream.zig");
const delete_delivery_stream = @import("delete_delivery_stream.zig");
const describe_delivery_stream = @import("describe_delivery_stream.zig");
const list_delivery_streams = @import("list_delivery_streams.zig");
const list_tags_for_delivery_stream = @import("list_tags_for_delivery_stream.zig");
const put_record = @import("put_record.zig");
const put_record_batch = @import("put_record_batch.zig");
const start_delivery_stream_encryption = @import("start_delivery_stream_encryption.zig");
const stop_delivery_stream_encryption = @import("stop_delivery_stream_encryption.zig");
const tag_delivery_stream = @import("tag_delivery_stream.zig");
const untag_delivery_stream = @import("untag_delivery_stream.zig");
const update_destination = @import("update_destination.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Firehose";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, config.retry_mode),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, config.retry_mode, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Creates a Firehose stream.
    ///
    /// By default, you can create up to 5,000 Firehose streams per Amazon Web
    /// Services
    /// Region.
    ///
    /// This is an asynchronous operation that immediately returns. The initial
    /// status of the
    /// Firehose stream is `CREATING`. After the Firehose stream is created, its
    /// status
    /// is `ACTIVE` and it now accepts data. If the Firehose stream creation fails,
    /// the
    /// status transitions to `CREATING_FAILED`. Attempts to send data to a delivery
    /// stream that is not in the `ACTIVE` state cause an exception. To check the
    /// state
    /// of a Firehose stream, use DescribeDeliveryStream.
    ///
    /// If the status of a Firehose stream is `CREATING_FAILED`, this status
    /// doesn't change, and you can't invoke `CreateDeliveryStream` again on it.
    /// However, you can invoke the DeleteDeliveryStream operation to delete
    /// it.
    ///
    /// A Firehose stream can be configured to receive records directly
    /// from providers using PutRecord or PutRecordBatch, or it
    /// can be configured to use an existing Kinesis stream as its source. To
    /// specify a Kinesis
    /// data stream as input, set the `DeliveryStreamType` parameter to
    /// `KinesisStreamAsSource`, and provide the Kinesis stream Amazon Resource Name
    /// (ARN) and role ARN in the `KinesisStreamSourceConfiguration`
    /// parameter.
    ///
    /// To create a Firehose stream with server-side encryption (SSE) enabled,
    /// include DeliveryStreamEncryptionConfigurationInput in your request. This is
    /// optional. You can also invoke StartDeliveryStreamEncryption to turn on
    /// SSE for an existing Firehose stream that doesn't have SSE enabled.
    ///
    /// A Firehose stream is configured with a single destination, such as Amazon
    /// Simple
    /// Storage Service (Amazon S3), Amazon Redshift, Amazon OpenSearch Service,
    /// Amazon OpenSearch
    /// Serverless, Splunk, and any custom HTTP endpoint or HTTP endpoints owned by
    /// or supported by
    /// third-party service providers, including Datadog, Dynatrace, LogicMonitor,
    /// MongoDB, New
    /// Relic, and Sumo Logic. You must specify only one of the following
    /// destination configuration
    /// parameters: `ExtendedS3DestinationConfiguration`,
    /// `S3DestinationConfiguration`,
    /// `ElasticsearchDestinationConfiguration`,
    /// `RedshiftDestinationConfiguration`, or
    /// `SplunkDestinationConfiguration`.
    ///
    /// When you specify `S3DestinationConfiguration`, you can also provide the
    /// following optional values: BufferingHints, `EncryptionConfiguration`, and
    /// `CompressionFormat`. By default, if no `BufferingHints` value is
    /// provided, Firehose buffers data up to 5 MB or for 5 minutes, whichever
    /// condition is satisfied first. `BufferingHints` is a hint, so there are some
    /// cases where the service cannot adhere to these conditions strictly. For
    /// example, record
    /// boundaries might be such that the size is a little over or under the
    /// configured buffering
    /// size. By default, no encryption is performed. We strongly recommend that you
    /// enable
    /// encryption to ensure secure data storage in Amazon S3.
    ///
    /// A few notes about Amazon Redshift as a destination:
    ///
    /// * An Amazon Redshift destination requires an S3 bucket as intermediate
    ///   location.
    /// Firehose first delivers data to Amazon S3 and then uses
    /// `COPY` syntax to load data into an Amazon Redshift table. This is
    /// specified in the `RedshiftDestinationConfiguration.S3Configuration`
    /// parameter.
    ///
    /// * The compression formats `SNAPPY` or `ZIP` cannot be
    /// specified in `RedshiftDestinationConfiguration.S3Configuration` because
    /// the Amazon Redshift `COPY` operation that reads from the S3 bucket doesn't
    /// support these compression formats.
    ///
    /// * We strongly recommend that you use the user name and password you provide
    /// exclusively with Firehose, and that the permissions for the account are
    /// restricted for Amazon Redshift `INSERT` permissions.
    ///
    /// Firehose assumes the IAM role that is configured as part of the
    /// destination. The role should allow the Firehose principal to assume the
    /// role,
    /// and the role should have permissions that allow the service to deliver the
    /// data. For more
    /// information, see [Grant Firehose Access to an Amazon S3
    /// Destination](https://docs.aws.amazon.com/firehose/latest/dev/controlling-access.html#using-iam-s3) in the *Amazon Firehose Developer Guide*.
    pub fn createDeliveryStream(self: *Self, allocator: std.mem.Allocator, input: create_delivery_stream.CreateDeliveryStreamInput, options: create_delivery_stream.Options) !create_delivery_stream.CreateDeliveryStreamOutput {
        return create_delivery_stream.execute(self, allocator, input, options);
    }

    /// Deletes a Firehose stream and its data.
    ///
    /// You can delete a Firehose stream only if it is in one of the following
    /// states:
    /// `ACTIVE`, `DELETING`, `CREATING_FAILED`, or
    /// `DELETING_FAILED`. You can't delete a Firehose stream that is in the
    /// `CREATING` state. To check the state of a Firehose stream, use
    /// DescribeDeliveryStream.
    ///
    /// DeleteDeliveryStream is an asynchronous API. When an API request to
    /// DeleteDeliveryStream succeeds, the Firehose stream is marked for deletion,
    /// and it goes into the
    /// `DELETING` state.While the Firehose stream is in the `DELETING` state, the
    /// service might
    /// continue to accept records, but it doesn't make any guarantees with respect
    /// to delivering
    /// the data. Therefore, as a best practice, first stop any applications that
    /// are sending
    /// records before you delete a Firehose stream.
    ///
    /// Removal of a Firehose stream that is in the `DELETING` state is a low
    /// priority operation for the service. A stream may remain in the
    /// `DELETING` state for several minutes. Therefore, as a best practice,
    /// applications should not wait for streams in the `DELETING` state
    /// to be removed.
    pub fn deleteDeliveryStream(self: *Self, allocator: std.mem.Allocator, input: delete_delivery_stream.DeleteDeliveryStreamInput, options: delete_delivery_stream.Options) !delete_delivery_stream.DeleteDeliveryStreamOutput {
        return delete_delivery_stream.execute(self, allocator, input, options);
    }

    /// Describes the specified Firehose stream and its status. For example, after
    /// your
    /// Firehose stream is created, call `DescribeDeliveryStream` to see whether the
    /// Firehose stream is `ACTIVE` and therefore ready for data to be sent to it.
    ///
    /// If the status of a Firehose stream is `CREATING_FAILED`, this status
    /// doesn't change, and you can't invoke CreateDeliveryStream again on it.
    /// However, you can invoke the DeleteDeliveryStream operation to delete it.
    /// If the status is `DELETING_FAILED`, you can force deletion by invoking
    /// DeleteDeliveryStream again but with
    /// DeleteDeliveryStreamInput$AllowForceDelete set to true.
    pub fn describeDeliveryStream(self: *Self, allocator: std.mem.Allocator, input: describe_delivery_stream.DescribeDeliveryStreamInput, options: describe_delivery_stream.Options) !describe_delivery_stream.DescribeDeliveryStreamOutput {
        return describe_delivery_stream.execute(self, allocator, input, options);
    }

    /// Lists your Firehose streams in alphabetical order of their names.
    ///
    /// The number of Firehose streams might be too large to return using a single
    /// call to
    /// `ListDeliveryStreams`. You can limit the number of Firehose streams
    /// returned,
    /// using the `Limit` parameter. To determine whether there are more delivery
    /// streams to list, check the value of `HasMoreDeliveryStreams` in the output.
    /// If
    /// there are more Firehose streams to list, you can request them by calling
    /// this operation
    /// again and setting the `ExclusiveStartDeliveryStreamName` parameter to the
    /// name
    /// of the last Firehose stream returned in the last call.
    pub fn listDeliveryStreams(self: *Self, allocator: std.mem.Allocator, input: list_delivery_streams.ListDeliveryStreamsInput, options: list_delivery_streams.Options) !list_delivery_streams.ListDeliveryStreamsOutput {
        return list_delivery_streams.execute(self, allocator, input, options);
    }

    /// Lists the tags for the specified Firehose stream. This operation has a limit
    /// of five
    /// transactions per second per account.
    pub fn listTagsForDeliveryStream(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_delivery_stream.ListTagsForDeliveryStreamInput, options: list_tags_for_delivery_stream.Options) !list_tags_for_delivery_stream.ListTagsForDeliveryStreamOutput {
        return list_tags_for_delivery_stream.execute(self, allocator, input, options);
    }

    /// Writes a single data record into an Firehose stream. To
    /// write multiple data records into a Firehose stream, use PutRecordBatch.
    /// Applications using these operations are referred to as producers.
    ///
    /// By default, each Firehose stream can take in up to 2,000 transactions per
    /// second,
    /// 5,000 records per second, or 5 MB per second. If you use PutRecord and
    /// PutRecordBatch, the limits are an aggregate across these two
    /// operations for each Firehose stream. For more information about limits and
    /// how to request
    /// an increase, see [Amazon
    /// Firehose
    /// Limits](https://docs.aws.amazon.com/firehose/latest/dev/limits.html).
    ///
    /// Firehose accumulates and publishes a particular metric for a customer
    /// account in one minute intervals. It is possible that the bursts of incoming
    /// bytes/records ingested to a Firehose stream last only for a few seconds. Due
    /// to this, the actual spikes in the traffic might not be fully visible in the
    /// customer's 1 minute CloudWatch metrics.
    ///
    /// You must specify the name of the Firehose stream and the data record when
    /// using PutRecord. The data record consists of a data blob that can be up to
    /// 1,000
    /// KiB in size, and any kind of data. For example, it can be a segment from a
    /// log file,
    /// geographic location data, website clickstream data, and so on.
    ///
    /// For multi record de-aggregation, you can not put more than 500 records even
    /// if the
    /// data blob length is less than 1000 KiB. If you include more than 500
    /// records, the request
    /// succeeds but the record de-aggregation doesn't work as expected and
    /// transformation lambda
    /// is invoked with the complete base64 encoded data blob instead of
    /// de-aggregated base64
    /// decoded records.
    ///
    /// Firehose buffers records before delivering them to the destination. To
    /// disambiguate the data blobs at the destination, a common solution is to use
    /// delimiters in
    /// the data, such as a newline (`\n`) or some other character unique within the
    /// data. This allows the consumer application to parse individual data items
    /// when reading the
    /// data from the destination.
    ///
    /// The `PutRecord` operation returns a `RecordId`, which is a
    /// unique string assigned to each record. Producer applications can use this ID
    /// for purposes
    /// such as auditability and investigation.
    ///
    /// If the `PutRecord` operation throws a
    /// `ServiceUnavailableException`, the API is automatically reinvoked (retried)
    /// 3
    /// times. If the exception persists, it is possible that the throughput limits
    /// have been
    /// exceeded for the Firehose stream.
    ///
    /// Re-invoking the Put API operations (for example, PutRecord and
    /// PutRecordBatch) can
    /// result in data duplicates. For larger data assets, allow for a longer time
    /// out before
    /// retrying Put API operations.
    ///
    /// Data records sent to Firehose are stored for 24 hours from the time they
    /// are added to a Firehose stream as it tries to send the records to the
    /// destination. If the
    /// destination is unreachable for more than 24 hours, the data is no longer
    /// available.
    ///
    /// Don't concatenate two or more base64 strings to form the data fields of your
    /// records.
    /// Instead, concatenate the raw data, then perform base64 encoding.
    pub fn putRecord(self: *Self, allocator: std.mem.Allocator, input: put_record.PutRecordInput, options: put_record.Options) !put_record.PutRecordOutput {
        return put_record.execute(self, allocator, input, options);
    }

    /// Writes multiple data records into a Firehose stream in a single call, which
    /// can
    /// achieve higher throughput per producer than when writing single records. To
    /// write single
    /// data records into a Firehose stream, use PutRecord. Applications using
    /// these operations are referred to as producers.
    ///
    /// Firehose accumulates and publishes a particular metric for a customer
    /// account in one minute intervals. It is possible that the bursts of incoming
    /// bytes/records ingested to a Firehose stream last only for a few seconds. Due
    /// to this, the actual spikes in the traffic might not be fully visible in the
    /// customer's 1 minute CloudWatch metrics.
    ///
    /// For information about service quota, see [Amazon Firehose
    /// Quota](https://docs.aws.amazon.com/firehose/latest/dev/limits.html).
    ///
    /// Each PutRecordBatch request supports up to 500 records. Each record
    /// in the request can be as large as 1,000 KB (before base64 encoding), up to a
    /// limit of 4 MB
    /// for the entire request. These limits cannot be changed.
    ///
    /// You must specify the name of the Firehose stream and the data record when
    /// using PutRecord. The data record consists of a data blob that can be up to
    /// 1,000
    /// KB in size, and any kind of data. For example, it could be a segment from a
    /// log file,
    /// geographic location data, website clickstream data, and so on.
    ///
    /// For multi record de-aggregation, you can not put more than 500 records even
    /// if the
    /// data blob length is less than 1000 KiB. If you include more than 500
    /// records, the request
    /// succeeds but the record de-aggregation doesn't work as expected and
    /// transformation lambda
    /// is invoked with the complete base64 encoded data blob instead of
    /// de-aggregated base64
    /// decoded records.
    ///
    /// Firehose buffers records before delivering them to the destination. To
    /// disambiguate the data blobs at the destination, a common solution is to use
    /// delimiters in
    /// the data, such as a newline (`\n`) or some other character unique within the
    /// data. This allows the consumer application to parse individual data items
    /// when reading the
    /// data from the destination.
    ///
    /// The PutRecordBatch response includes a count of failed records,
    /// `FailedPutCount`, and an array of responses, `RequestResponses`.
    /// Even if the PutRecordBatch call succeeds, the value of
    /// `FailedPutCount` may be greater than 0, indicating that there are records
    /// for
    /// which the operation didn't succeed. Each entry in the `RequestResponses`
    /// array
    /// provides additional information about the processed record. It directly
    /// correlates with a
    /// record in the request array using the same ordering, from the top to the
    /// bottom. The
    /// response array always includes the same number of records as the request
    /// array.
    /// `RequestResponses` includes both successfully and unsuccessfully processed
    /// records. Firehose tries to process all records in each PutRecordBatch
    /// request. A single record failure does not stop the processing
    /// of subsequent records.
    ///
    /// A successfully processed record includes a `RecordId` value, which is
    /// unique for the record. An unsuccessfully processed record includes
    /// `ErrorCode`
    /// and `ErrorMessage` values. `ErrorCode` reflects the type of error,
    /// and is one of the following values: `ServiceUnavailableException` or
    /// `InternalFailure`. `ErrorMessage` provides more detailed
    /// information about the error.
    ///
    /// If there is an internal server error or a timeout, the write might have
    /// completed or
    /// it might have failed. If `FailedPutCount` is greater than 0, retry the
    /// request,
    /// resending only those records that might have failed processing. This
    /// minimizes the possible
    /// duplicate records and also reduces the total bytes sent (and corresponding
    /// charges). We
    /// recommend that you handle any duplicates at the destination.
    ///
    /// If PutRecordBatch throws `ServiceUnavailableException`,
    /// the API is automatically reinvoked (retried) 3 times. If the exception
    /// persists, it is
    /// possible that the throughput limits have been exceeded for the Firehose
    /// stream.
    ///
    /// Re-invoking the Put API operations (for example, PutRecord and
    /// PutRecordBatch) can
    /// result in data duplicates. For larger data assets, allow for a longer time
    /// out before
    /// retrying Put API operations.
    ///
    /// Data records sent to Firehose are stored for 24 hours from the time they
    /// are added to a Firehose stream as it attempts to send the records to the
    /// destination. If
    /// the destination is unreachable for more than 24 hours, the data is no longer
    /// available.
    ///
    /// Don't concatenate two or more base64 strings to form the data fields of your
    /// records.
    /// Instead, concatenate the raw data, then perform base64 encoding.
    pub fn putRecordBatch(self: *Self, allocator: std.mem.Allocator, input: put_record_batch.PutRecordBatchInput, options: put_record_batch.Options) !put_record_batch.PutRecordBatchOutput {
        return put_record_batch.execute(self, allocator, input, options);
    }

    /// Enables server-side encryption (SSE) for the Firehose stream.
    ///
    /// This operation is asynchronous. It returns immediately. When you invoke it,
    /// Firehose first sets the encryption status of the stream to `ENABLING`, and
    /// then
    /// to `ENABLED`. The encryption status of a Firehose stream is the
    /// `Status` property in DeliveryStreamEncryptionConfiguration.
    /// If the operation fails, the encryption status changes to `ENABLING_FAILED`.
    /// You
    /// can continue to read and write data to your Firehose stream while the
    /// encryption status is
    /// `ENABLING`, but the data is not encrypted. It can take up to 5 seconds after
    /// the encryption status changes to `ENABLED` before all records written to the
    /// Firehose stream are encrypted. To find out whether a record or a batch of
    /// records was
    /// encrypted, check the response elements PutRecordOutput$Encrypted and
    /// PutRecordBatchOutput$Encrypted, respectively.
    ///
    /// To check the encryption status of a Firehose stream, use
    /// DescribeDeliveryStream.
    ///
    /// Even if encryption is currently enabled for a Firehose stream, you can still
    /// invoke this
    /// operation on it to change the ARN of the CMK or both its type and ARN. If
    /// you invoke this
    /// method to change the CMK, and the old CMK is of type `CUSTOMER_MANAGED_CMK`,
    /// Firehose schedules the grant it had on the old CMK for retirement. If the
    /// new
    /// CMK is of type `CUSTOMER_MANAGED_CMK`, Firehose creates a grant
    /// that enables it to use the new CMK to encrypt and decrypt data and to manage
    /// the
    /// grant.
    ///
    /// For the KMS grant creation to be successful, the Firehose API operations
    /// `StartDeliveryStreamEncryption` and `CreateDeliveryStream` should
    /// not be called with session credentials that are more than 6 hours old.
    ///
    /// If a Firehose stream already has encryption enabled and then you invoke this
    /// operation
    /// to change the ARN of the CMK or both its type and ARN and you get
    /// `ENABLING_FAILED`, this only means that the attempt to change the CMK
    /// failed.
    /// In this case, encryption remains enabled with the old CMK.
    ///
    /// If the encryption status of your Firehose stream is `ENABLING_FAILED`, you
    /// can invoke this operation again with a valid CMK. The CMK must be enabled
    /// and the key
    /// policy mustn't explicitly deny the permission for Firehose to invoke KMS
    /// encrypt and decrypt operations.
    ///
    /// You can enable SSE for a Firehose stream only if it's a Firehose stream that
    /// uses
    /// `DirectPut` as its source.
    ///
    /// The `StartDeliveryStreamEncryption` and
    /// `StopDeliveryStreamEncryption` operations have a combined limit of 25 calls
    /// per Firehose stream per 24 hours. For example, you reach the limit if you
    /// call
    /// `StartDeliveryStreamEncryption` 13 times and
    /// `StopDeliveryStreamEncryption` 12 times for the same Firehose stream in a
    /// 24-hour period.
    pub fn startDeliveryStreamEncryption(self: *Self, allocator: std.mem.Allocator, input: start_delivery_stream_encryption.StartDeliveryStreamEncryptionInput, options: start_delivery_stream_encryption.Options) !start_delivery_stream_encryption.StartDeliveryStreamEncryptionOutput {
        return start_delivery_stream_encryption.execute(self, allocator, input, options);
    }

    /// Disables server-side encryption (SSE) for the Firehose stream.
    ///
    /// This operation is asynchronous. It returns immediately. When you invoke it,
    /// Firehose first sets the encryption status of the stream to `DISABLING`, and
    /// then
    /// to `DISABLED`. You can continue to read and write data to your stream while
    /// its
    /// status is `DISABLING`. It can take up to 5 seconds after the encryption
    /// status
    /// changes to `DISABLED` before all records written to the Firehose stream are
    /// no
    /// longer subject to encryption. To find out whether a record or a batch of
    /// records was
    /// encrypted, check the response elements PutRecordOutput$Encrypted and
    /// PutRecordBatchOutput$Encrypted, respectively.
    ///
    /// To check the encryption state of a Firehose stream, use
    /// DescribeDeliveryStream.
    ///
    /// If SSE is enabled using a customer managed CMK and then you invoke
    /// `StopDeliveryStreamEncryption`, Firehose schedules the related
    /// KMS grant for retirement and then retires it after it ensures that it is
    /// finished
    /// delivering records to the destination.
    ///
    /// The `StartDeliveryStreamEncryption` and
    /// `StopDeliveryStreamEncryption` operations have a combined limit of 25 calls
    /// per Firehose stream per 24 hours. For example, you reach the limit if you
    /// call
    /// `StartDeliveryStreamEncryption` 13 times and
    /// `StopDeliveryStreamEncryption` 12 times for the same Firehose stream in a
    /// 24-hour period.
    pub fn stopDeliveryStreamEncryption(self: *Self, allocator: std.mem.Allocator, input: stop_delivery_stream_encryption.StopDeliveryStreamEncryptionInput, options: stop_delivery_stream_encryption.Options) !stop_delivery_stream_encryption.StopDeliveryStreamEncryptionOutput {
        return stop_delivery_stream_encryption.execute(self, allocator, input, options);
    }

    /// Adds or updates tags for the specified Firehose stream. A tag is a key-value
    /// pair
    /// that you can define and assign to Amazon Web Services resources. If you
    /// specify a tag that
    /// already exists, the tag value is replaced with the value that you specify in
    /// the request.
    /// Tags are metadata. For example, you can add friendly names and descriptions
    /// or other types
    /// of information that can help you distinguish the Firehose stream. For more
    /// information
    /// about tags, see [Using Cost Allocation
    /// Tags](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/cost-alloc-tags.html) in the *Amazon Web Services Billing and Cost Management User
    /// Guide*.
    ///
    /// Each Firehose stream can have up to 50 tags.
    ///
    /// This operation has a limit of five transactions per second per account.
    pub fn tagDeliveryStream(self: *Self, allocator: std.mem.Allocator, input: tag_delivery_stream.TagDeliveryStreamInput, options: tag_delivery_stream.Options) !tag_delivery_stream.TagDeliveryStreamOutput {
        return tag_delivery_stream.execute(self, allocator, input, options);
    }

    /// Removes tags from the specified Firehose stream. Removed tags are deleted,
    /// and you
    /// can't recover them after this operation successfully completes.
    ///
    /// If you specify a tag that doesn't exist, the operation ignores it.
    ///
    /// This operation has a limit of five transactions per second per account.
    pub fn untagDeliveryStream(self: *Self, allocator: std.mem.Allocator, input: untag_delivery_stream.UntagDeliveryStreamInput, options: untag_delivery_stream.Options) !untag_delivery_stream.UntagDeliveryStreamOutput {
        return untag_delivery_stream.execute(self, allocator, input, options);
    }

    /// Updates the specified destination of the specified Firehose stream.
    ///
    /// Use this operation to change the destination type (for example, to replace
    /// the Amazon
    /// S3 destination with Amazon Redshift) or change the parameters associated
    /// with a destination
    /// (for example, to change the bucket name of the Amazon S3 destination). The
    /// update might not
    /// occur immediately. The target Firehose stream remains active while the
    /// configurations are
    /// updated, so data writes to the Firehose stream can continue during this
    /// process. The
    /// updated configurations are usually effective within a few minutes.
    ///
    /// Switching between Amazon OpenSearch Service and other services is not
    /// supported. For
    /// an Amazon OpenSearch Service destination, you can only update to another
    /// Amazon OpenSearch
    /// Service destination.
    ///
    /// If the destination type is the same, Firehose merges the configuration
    /// parameters specified with the destination configuration that already exists
    /// on the delivery
    /// stream. If any of the parameters are not specified in the call, the existing
    /// values are
    /// retained. For example, in the Amazon S3 destination, if
    /// EncryptionConfiguration is not specified, then the existing
    /// `EncryptionConfiguration` is maintained on the destination.
    ///
    /// If the destination type is not the same, for example, changing the
    /// destination from
    /// Amazon S3 to Amazon Redshift, Firehose does not merge any parameters. In
    /// this
    /// case, all parameters must be specified.
    ///
    /// Firehose uses `CurrentDeliveryStreamVersionId` to avoid race
    /// conditions and conflicting merges. This is a required field, and the service
    /// updates the
    /// configuration only if the existing configuration has a version ID that
    /// matches. After the
    /// update is applied successfully, the version ID is updated, and can be
    /// retrieved using DescribeDeliveryStream. Use the new version ID to set
    /// `CurrentDeliveryStreamVersionId` in the next call.
    pub fn updateDestination(self: *Self, allocator: std.mem.Allocator, input: update_destination.UpdateDestinationInput, options: update_destination.Options) !update_destination.UpdateDestinationOutput {
        return update_destination.execute(self, allocator, input, options);
    }
};
