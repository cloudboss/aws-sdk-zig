/// Filters to use when listing TagOptions.
pub const ListTagOptionsFilters = struct {
    /// The active state.
    active: ?bool = null,

    /// The TagOption key.
    key: ?[]const u8 = null,

    /// The TagOption value.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .active = "Active",
        .key = "Key",
        .value = "Value",
    };
};
