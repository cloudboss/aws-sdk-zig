const SourceType = @import("source_type.zig").SourceType;

/// This data type is used as a response element in the
/// [DescribeEvents](https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_DescribeEvents.html) action.
pub const Event = struct {
    /// Specifies the date and time of the event.
    date: ?i64,

    /// Specifies the category for the event.
    event_categories: ?[]const []const u8,

    /// Provides the text of this event.
    message: ?[]const u8,

    /// The Amazon Resource Name (ARN) for the event.
    source_arn: ?[]const u8,

    /// Provides the identifier for the source of the event.
    source_identifier: ?[]const u8,

    /// Specifies the source type for this event.
    source_type: ?SourceType,
};
