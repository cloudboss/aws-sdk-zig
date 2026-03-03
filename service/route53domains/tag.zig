/// Each tag includes the following elements.
pub const Tag = struct {
    /// The key (name) of a tag.
    ///
    /// Valid values: A-Z, a-z, 0-9, space, ".:/=+\-@"
    ///
    /// Constraints: Each key can be 1-128 characters long.
    key: ?[]const u8 = null,

    /// The value of a tag.
    ///
    /// Valid values: A-Z, a-z, 0-9, space, ".:/=+\-@"
    ///
    /// Constraints: Each value can be 0-256 characters long.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
