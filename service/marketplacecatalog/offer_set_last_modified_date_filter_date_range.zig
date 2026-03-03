/// Allows filtering on the `LastModifiedDate` of an offer set with date range
/// as input.
pub const OfferSetLastModifiedDateFilterDateRange = struct {
    /// Allows filtering on the `LastModifiedDate` of an offer set after a date.
    after_value: ?[]const u8 = null,

    /// Allows filtering on the `LastModifiedDate` of an offer set before a date.
    before_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .after_value = "AfterValue",
        .before_value = "BeforeValue",
    };
};
