const EventSubscriptionSegmentStatus = @import("event_subscription_segment_status.zig").EventSubscriptionSegmentStatus;

/// Represents a segment associated with a membership event stream.
pub const AssociatedSegment = struct {
    /// An optional message providing context, such as a failure reason.
    message: ?[]const u8 = null,

    /// The unique name of the segment definition.
    segment_name: ?[]const u8 = null,

    /// The subscription status of the segment. The following are valid values:
    ///
    /// * **STARTING**: The segment is being prepared to publish
    /// membership events.
    ///
    /// * **RUNNING**: The segment is actively publishing
    /// membership events to the stream.
    ///
    /// * **STOPPED**: The segment has stopped publishing
    /// membership events.
    ///
    /// * **FAILED**: The segment failed to publish membership
    /// events.
    status: ?EventSubscriptionSegmentStatus = null,

    pub const json_field_names = .{
        .message = "Message",
        .segment_name = "SegmentName",
        .status = "Status",
    };
};
