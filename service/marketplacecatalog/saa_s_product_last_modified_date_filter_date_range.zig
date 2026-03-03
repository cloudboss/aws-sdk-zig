/// Object that contains date range of the last modified date to be filtered on.
/// You can optionally provide a `BeforeValue` and/or `AfterValue`. Both are
/// inclusive.
pub const SaaSProductLastModifiedDateFilterDateRange = struct {
    /// Date after which the SaaS product was last modified.
    after_value: ?[]const u8 = null,

    /// Date before which the SaaS product was last modified.
    before_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .after_value = "AfterValue",
        .before_value = "BeforeValue",
    };
};
