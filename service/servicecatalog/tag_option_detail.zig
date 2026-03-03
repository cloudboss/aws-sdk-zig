/// Information about a TagOption.
pub const TagOptionDetail = struct {
    /// The TagOption active state.
    active: ?bool = null,

    /// The TagOption identifier.
    id: ?[]const u8 = null,

    /// The TagOption key.
    key: ?[]const u8 = null,

    /// The Amazon Web Services account Id of the owner account that created the
    /// TagOption.
    owner: ?[]const u8 = null,

    /// The TagOption value.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .active = "Active",
        .id = "Id",
        .key = "Key",
        .owner = "Owner",
        .value = "Value",
    };
};
