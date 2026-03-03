const OfferSetLastModifiedDateFilterDateRange = @import("offer_set_last_modified_date_filter_date_range.zig").OfferSetLastModifiedDateFilterDateRange;

/// Allows filtering on the `LastModifiedDate` of an offer set.
pub const OfferSetLastModifiedDateFilter = struct {
    /// Allows filtering on the `LastModifiedDate` of an offer set with date range
    /// as input.
    date_range: ?OfferSetLastModifiedDateFilterDateRange = null,

    pub const json_field_names = .{
        .date_range = "DateRange",
    };
};
