/// JSON delta containing partial JSON
pub const SendMessageJsonDelta = struct {
    /// Partial JSON string
    partial_json: ?[]const u8 = null,

    pub const json_field_names = .{
        .partial_json = "partialJson",
    };
};
