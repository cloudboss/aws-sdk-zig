/// Information about a reference when the `referenceType` is `EMAIL`.
/// Otherwise, null.
pub const EmailReference = struct {
    /// Identifier of the email reference.
    name: ?[]const u8 = null,

    /// A valid email address.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};
