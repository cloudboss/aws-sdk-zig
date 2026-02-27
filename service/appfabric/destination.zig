const FirehoseStream = @import("firehose_stream.zig").FirehoseStream;
const S3Bucket = @import("s3_bucket.zig").S3Bucket;

/// Contains information about an audit log destination.
pub const Destination = union(enum) {
    /// Contains information about an Amazon Kinesis Data Firehose delivery stream.
    firehose_stream: ?FirehoseStream,
    /// Contains information about an Amazon S3 bucket.
    s_3_bucket: ?S3Bucket,

    pub const json_field_names = .{
        .firehose_stream = "firehoseStream",
        .s_3_bucket = "s3Bucket",
    };
};
