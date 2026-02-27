/// The attribute error.
pub const AttributeError = struct {
    /// The attribute ID as part of the attribute error.
    attribute_identifier: []const u8,

    /// The code generated as part of the attribute error.
    code: []const u8,

    /// The message generated as part of the attribute error.
    message: []const u8,

    pub const json_field_names = .{
        .attribute_identifier = "attributeIdentifier",
        .code = "code",
        .message = "message",
    };
};
