const OfferReleaseDateFilterDateRange = @import("offer_release_date_filter_date_range.zig").OfferReleaseDateFilterDateRange;

/// Allows filtering on the `ReleaseDate` of an offer.
pub const OfferReleaseDateFilter = struct {
    /// Allows filtering on the `ReleaseDate` of an offer with date range as input.
    date_range: ?OfferReleaseDateFilterDateRange,

    pub const json_field_names = .{
        .date_range = "DateRange",
    };
};
