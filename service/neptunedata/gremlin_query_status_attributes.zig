/// Contains status components of a Gremlin query.
pub const GremlinQueryStatusAttributes = struct {
    /// Attributes of the Gremlin query status.
    attributes: ?[]const u8 = null,

    /// The HTTP response code returned fro the Gremlin query request..
    code: ?i32 = null,

    /// The status message.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .attributes = "attributes",
        .code = "code",
        .message = "message",
    };
};
