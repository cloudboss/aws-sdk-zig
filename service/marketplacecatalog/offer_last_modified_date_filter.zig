const OfferLastModifiedDateFilterDateRange = @import("offer_last_modified_date_filter_date_range.zig").OfferLastModifiedDateFilterDateRange;

/// Allows filtering on the `LastModifiedDate` of an offer.
pub const OfferLastModifiedDateFilter = struct {
    /// Allows filtering on the `LastModifiedDate` of an offer with date range as
    /// input.
    date_range: ?OfferLastModifiedDateFilterDateRange,

    pub const json_field_names = .{
        .date_range = "DateRange",
    };
};
