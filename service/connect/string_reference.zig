/// Information about a reference when the `referenceType` is `STRING`.
/// Otherwise,
/// null.
pub const StringReference = struct {
    /// Identifier of the string reference.
    name: ?[]const u8,

    /// A valid string.
    value: ?[]const u8,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};
