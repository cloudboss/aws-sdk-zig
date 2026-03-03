/// This data type is used in the ImageScanFinding data type.
pub const Attribute = struct {
    /// The attribute key.
    key: []const u8,

    /// The value assigned to the attribute key.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
