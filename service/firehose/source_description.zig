const DatabaseSourceDescription = @import("database_source_description.zig").DatabaseSourceDescription;
const DirectPutSourceDescription = @import("direct_put_source_description.zig").DirectPutSourceDescription;
const KinesisStreamSourceDescription = @import("kinesis_stream_source_description.zig").KinesisStreamSourceDescription;
const MSKSourceDescription = @import("msk_source_description.zig").MSKSourceDescription;

/// Details about a Kinesis data stream used as the source for a Firehose
/// stream.
pub const SourceDescription = struct {
    /// Details about a database used as the source for a Firehose stream.
    ///
    /// Amazon Data Firehose is in preview release and is subject to change.
    database_source_description: ?DatabaseSourceDescription = null,

    /// Details about Direct PUT used as the source for a Firehose stream.
    direct_put_source_description: ?DirectPutSourceDescription = null,

    /// The KinesisStreamSourceDescription value for the source Kinesis
    /// data stream.
    kinesis_stream_source_description: ?KinesisStreamSourceDescription = null,

    /// The configuration description for the Amazon MSK cluster to be used as the
    /// source for a delivery
    /// stream.
    msk_source_description: ?MSKSourceDescription = null,

    pub const json_field_names = .{
        .database_source_description = "DatabaseSourceDescription",
        .direct_put_source_description = "DirectPutSourceDescription",
        .kinesis_stream_source_description = "KinesisStreamSourceDescription",
        .msk_source_description = "MSKSourceDescription",
    };
};
