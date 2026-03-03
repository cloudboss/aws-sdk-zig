/// Allows filtering on the `ReleaseDate` of an offer with date range as input.
pub const OfferReleaseDateFilterDateRange = struct {
    /// Allows filtering on the `ReleaseDate` of offers after a date.
    after_value: ?[]const u8 = null,

    /// Allows filtering on the `ReleaseDate` of offers before a date.
    before_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .after_value = "AfterValue",
        .before_value = "BeforeValue",
    };
};
