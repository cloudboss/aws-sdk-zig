/// Allows filtering on the `ReleaseDate` of an offer set with date range as
/// input.
pub const OfferSetReleaseDateFilterDateRange = struct {
    /// Allows filtering on the `ReleaseDate` of offer set after a date.
    after_value: ?[]const u8,

    /// Allows filtering on the `ReleaseDate` of offer set before a date.
    before_value: ?[]const u8,

    pub const json_field_names = .{
        .after_value = "AfterValue",
        .before_value = "BeforeValue",
    };
};
