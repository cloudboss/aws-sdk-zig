/// Information about a reference when the `referenceType` is `NUMBER`.
/// Otherwise,
/// null.
pub const NumberReference = struct {
    /// Identifier of the number reference.
    name: ?[]const u8 = null,

    /// A valid number.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};
