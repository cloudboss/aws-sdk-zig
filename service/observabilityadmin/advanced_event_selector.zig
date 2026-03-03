const AdvancedFieldSelector = @import("advanced_field_selector.zig").AdvancedFieldSelector;

/// Advanced event selectors let you create fine-grained selectors for
/// management, data, and network activity events.
pub const AdvancedEventSelector = struct {
    /// Contains all selector statements in an advanced event selector.
    field_selectors: []const AdvancedFieldSelector,

    /// An optional, descriptive name for an advanced event selector, such as "Log
    /// data events for only two S3 buckets".
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .field_selectors = "FieldSelectors",
        .name = "Name",
    };
};
