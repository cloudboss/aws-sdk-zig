const Status = @import("status.zig").Status;

/// An object describing a Kinesis video stream.
pub const StreamInfo = struct {
    /// A time stamp that indicates when the stream was created.
    creation_time: ?i64 = null,

    /// How long the stream retains data, in hours.
    data_retention_in_hours: ?i32 = null,

    /// The name of the device that is associated with the stream.
    device_name: ?[]const u8 = null,

    /// The ID of the Key Management Service (KMS) key that Kinesis Video Streams
    /// uses to encrypt data on the stream.
    kms_key_id: ?[]const u8 = null,

    /// The `MediaType` of the stream.
    media_type: ?[]const u8 = null,

    /// The status of the stream.
    status: ?Status = null,

    /// The Amazon Resource Name (ARN) of the stream.
    stream_arn: ?[]const u8 = null,

    /// The name of the stream.
    stream_name: ?[]const u8 = null,

    /// The version of the stream.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .data_retention_in_hours = "DataRetentionInHours",
        .device_name = "DeviceName",
        .kms_key_id = "KmsKeyId",
        .media_type = "MediaType",
        .status = "Status",
        .stream_arn = "StreamARN",
        .stream_name = "StreamName",
        .version = "Version",
    };
};
