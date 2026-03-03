/// Information about the payload of an event recording Amazon CodeCatalyst
/// activity.
pub const EventPayload = struct {
    /// The type of content in the event payload.
    content_type: ?[]const u8 = null,

    /// The data included in the event payload.
    data: ?[]const u8 = null,

    pub const json_field_names = .{
        .content_type = "contentType",
        .data = "data",
    };
};
