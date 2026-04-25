/// Indicates that the synthesis stream is closed and provides summary
/// information.
pub const StreamClosedEvent = struct {
    /// The total number of characters synthesized during the streaming session.
    request_characters: i32 = 0,

    pub const json_field_names = .{
        .request_characters = "RequestCharacters",
    };
};
