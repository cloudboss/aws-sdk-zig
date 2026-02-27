const OfferSetReleaseDateFilterDateRange = @import("offer_set_release_date_filter_date_range.zig").OfferSetReleaseDateFilterDateRange;

/// Allows filtering on the `ReleaseDate` of an offer set.
pub const OfferSetReleaseDateFilter = struct {
    /// Allows filtering on the `ReleaseDate` of an offer set with date range as
    /// input.
    date_range: ?OfferSetReleaseDateFilterDateRange,

    pub const json_field_names = .{
        .date_range = "DateRange",
    };
};
