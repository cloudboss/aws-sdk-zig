const DeliveryStreamEncryptionConfiguration = @import("delivery_stream_encryption_configuration.zig").DeliveryStreamEncryptionConfiguration;
const DeliveryStreamStatus = @import("delivery_stream_status.zig").DeliveryStreamStatus;
const DeliveryStreamType = @import("delivery_stream_type.zig").DeliveryStreamType;
const DestinationDescription = @import("destination_description.zig").DestinationDescription;
const FailureDescription = @import("failure_description.zig").FailureDescription;
const SourceDescription = @import("source_description.zig").SourceDescription;

/// Contains information about a Firehose stream.
pub const DeliveryStreamDescription = struct {
    /// The date and time that the Firehose stream was created.
    create_timestamp: ?i64,

    /// The Amazon Resource Name (ARN) of the Firehose stream. For more information,
    /// see
    /// [Amazon
    /// Resource Names (ARNs) and Amazon Web Services Service
    /// Namespaces](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html).
    delivery_stream_arn: []const u8,

    /// Indicates the server-side encryption (SSE) status for the Firehose stream.
    delivery_stream_encryption_configuration: ?DeliveryStreamEncryptionConfiguration,

    /// The name of the Firehose stream.
    delivery_stream_name: []const u8,

    /// The status of the Firehose stream. If the status of a Firehose stream is
    /// `CREATING_FAILED`, this status doesn't change, and you can't invoke
    /// `CreateDeliveryStream` again on it. However, you can invoke the
    /// DeleteDeliveryStream operation to delete it.
    delivery_stream_status: DeliveryStreamStatus,

    /// The Firehose stream type. This can be one of the following values:
    ///
    /// * `DirectPut`: Provider applications access the Firehose stream
    /// directly.
    ///
    /// * `KinesisStreamAsSource`: The Firehose stream uses a Kinesis data
    /// stream as a source.
    delivery_stream_type: DeliveryStreamType,

    /// The destinations.
    destinations: []const DestinationDescription,

    /// Provides details in case one of the following operations fails due to an
    /// error related
    /// to KMS: CreateDeliveryStream, DeleteDeliveryStream,
    /// StartDeliveryStreamEncryption, StopDeliveryStreamEncryption.
    failure_description: ?FailureDescription,

    /// Indicates whether there are more destinations available to list.
    has_more_destinations: bool,

    /// The date and time that the Firehose stream was last updated.
    last_update_timestamp: ?i64,

    /// If the `DeliveryStreamType` parameter is
    /// `KinesisStreamAsSource`, a SourceDescription object
    /// describing the source Kinesis data stream.
    source: ?SourceDescription,

    /// Each time the destination is updated for a Firehose stream, the version ID
    /// is
    /// changed, and the current version ID is required when updating the
    /// destination. This is so
    /// that the service knows it is applying the changes to the correct version of
    /// the delivery
    /// stream.
    version_id: []const u8,

    pub const json_field_names = .{
        .create_timestamp = "CreateTimestamp",
        .delivery_stream_arn = "DeliveryStreamARN",
        .delivery_stream_encryption_configuration = "DeliveryStreamEncryptionConfiguration",
        .delivery_stream_name = "DeliveryStreamName",
        .delivery_stream_status = "DeliveryStreamStatus",
        .delivery_stream_type = "DeliveryStreamType",
        .destinations = "Destinations",
        .failure_description = "FailureDescription",
        .has_more_destinations = "HasMoreDestinations",
        .last_update_timestamp = "LastUpdateTimestamp",
        .source = "Source",
        .version_id = "VersionId",
    };
};
