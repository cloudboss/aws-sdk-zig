/// Describes Amazon Kinesis Data Firehose logging options.
pub const VerifiedAccessLogKinesisDataFirehoseDestinationOptions = struct {
    /// The ID of the delivery stream.
    delivery_stream: ?[]const u8,

    /// Indicates whether logging is enabled.
    enabled: bool,
};
