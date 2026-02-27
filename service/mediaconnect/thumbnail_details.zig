const MessageDetail = @import("message_detail.zig").MessageDetail;

/// The details of the thumbnail, including thumbnail base64 string, timecode
/// and the time when thumbnail was generated.
pub const ThumbnailDetails = struct {
    /// The ARN of the flow that DescribeFlowSourceThumbnail was performed on.
    flow_arn: []const u8,

    /// Thumbnail Base64 string.
    thumbnail: ?[]const u8,

    /// Status code and messages about the flow source thumbnail.
    thumbnail_messages: []const MessageDetail,

    /// Timecode of thumbnail.
    timecode: ?[]const u8,

    /// The timestamp of when thumbnail was generated.
    timestamp: ?i64,

    pub const json_field_names = .{
        .flow_arn = "FlowArn",
        .thumbnail = "Thumbnail",
        .thumbnail_messages = "ThumbnailMessages",
        .timecode = "Timecode",
        .timestamp = "Timestamp",
    };
};
