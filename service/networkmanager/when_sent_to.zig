/// Displays a list of the destination segments. Used only when the service
/// insertion
/// action is `send-to`.
pub const WhenSentTo = struct {
    /// The list of destination segments when the service insertion action is
    /// `send-to`.
    when_sent_to_segments_list: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .when_sent_to_segments_list = "WhenSentToSegmentsList",
    };
};
