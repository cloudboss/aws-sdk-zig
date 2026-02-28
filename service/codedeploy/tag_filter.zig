const TagFilterType = @import("tag_filter_type.zig").TagFilterType;

/// Information about an on-premises instance tag filter.
pub const TagFilter = struct {
    /// The on-premises instance tag filter key.
    key: ?[]const u8,

    /// The on-premises instance tag filter type:
    ///
    /// * KEY_ONLY: Key only.
    ///
    /// * VALUE_ONLY: Value only.
    ///
    /// * KEY_AND_VALUE: Key and value.
    type: ?TagFilterType,

    /// The on-premises instance tag filter value.
    value: ?[]const u8,

    pub const json_field_names = .{
        .key = "Key",
        .type = "Type",
        .value = "Value",
    };
};
