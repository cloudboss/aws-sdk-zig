const aws = @import("aws");

const AttributeValue = @import("attribute_value.zig").AttributeValue;
const StreamViewType = @import("stream_view_type.zig").StreamViewType;

/// A description of a single data modification that was performed on an item in
/// a DynamoDB table.
pub const StreamRecord = struct {
    /// The approximate date and time when the stream record was created, in [ISO
    /// 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format and
    /// rounded down to the closest second.
    approximate_creation_date_time: ?i64 = null,

    /// The primary key attribute(s) for the DynamoDB item that was modified.
    keys: ?[]const aws.map.MapEntry(AttributeValue) = null,

    /// The item in the DynamoDB table as it appeared after it was modified.
    new_image: ?[]const aws.map.MapEntry(AttributeValue) = null,

    /// The item in the DynamoDB table as it appeared before it was modified.
    old_image: ?[]const aws.map.MapEntry(AttributeValue) = null,

    /// The sequence number of the stream record.
    sequence_number: ?[]const u8 = null,

    /// The size of the stream record, in bytes.
    size_bytes: ?i64 = null,

    /// The type of data from the modified DynamoDB item that was captured in this
    /// stream record:
    ///
    /// * `KEYS_ONLY` - only the key attributes of the modified item.
    ///
    /// * `NEW_IMAGE` - the entire item, as it appeared after it was modified.
    ///
    /// * `OLD_IMAGE` - the entire item, as it appeared before it was modified.
    ///
    /// * `NEW_AND_OLD_IMAGES` - both the new and the old item images of the item.
    stream_view_type: ?StreamViewType = null,

    pub const json_field_names = .{
        .approximate_creation_date_time = "ApproximateCreationDateTime",
        .keys = "Keys",
        .new_image = "NewImage",
        .old_image = "OldImage",
        .sequence_number = "SequenceNumber",
        .size_bytes = "SizeBytes",
        .stream_view_type = "StreamViewType",
    };
};
