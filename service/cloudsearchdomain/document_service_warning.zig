/// A warning returned by the document service when an issue is discovered while
/// processing an upload request.
pub const DocumentServiceWarning = struct {
    /// The description for a warning returned by the document service.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "message",
    };
};
