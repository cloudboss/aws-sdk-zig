/// Allows filtering on the `LastModifiedDate` of an offer with date range as
/// input.
pub const OfferLastModifiedDateFilterDateRange = struct {
    /// Allows filtering on the `LastModifiedDate` of an offer after a date.
    after_value: ?[]const u8,

    /// Allows filtering on the `LastModifiedDate` of an offer before a date.
    before_value: ?[]const u8,

    pub const json_field_names = .{
        .after_value = "AfterValue",
        .before_value = "BeforeValue",
    };
};
