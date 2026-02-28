const EC2TagFilterType = @import("ec2_tag_filter_type.zig").EC2TagFilterType;

/// Information about an EC2 tag filter.
pub const EC2TagFilter = struct {
    /// The tag filter key.
    key: ?[]const u8,

    /// The tag filter type:
    ///
    /// * `KEY_ONLY`: Key only.
    ///
    /// * `VALUE_ONLY`: Value only.
    ///
    /// * `KEY_AND_VALUE`: Key and value.
    @"type": ?EC2TagFilterType,

    /// The tag filter value.
    value: ?[]const u8,

    pub const json_field_names = .{
        .key = "Key",
        .@"type" = "Type",
        .value = "Value",
    };
};
