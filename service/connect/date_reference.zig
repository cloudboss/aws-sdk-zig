/// Information about a reference when the `referenceType` is `DATE`. Otherwise,
/// null.
pub const DateReference = struct {
    /// Identifier of the date reference.
    name: ?[]const u8 = null,

    /// A valid date.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};
