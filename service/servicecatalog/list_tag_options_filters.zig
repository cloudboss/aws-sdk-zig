/// Filters to use when listing TagOptions.
pub const ListTagOptionsFilters = struct {
    /// The active state.
    active: ?bool,

    /// The TagOption key.
    key: ?[]const u8,

    /// The TagOption value.
    value: ?[]const u8,

    pub const json_field_names = .{
        .active = "Active",
        .key = "Key",
        .value = "Value",
    };
};
