const OfferAvailabilityEndDateFilterDateRange = @import("offer_availability_end_date_filter_date_range.zig").OfferAvailabilityEndDateFilterDateRange;

/// Allows filtering on the `AvailabilityEndDate` of an offer.
pub const OfferAvailabilityEndDateFilter = struct {
    /// Allows filtering on the `AvailabilityEndDate` of an offer with date range as
    /// input.
    date_range: ?OfferAvailabilityEndDateFilterDateRange,

    pub const json_field_names = .{
        .date_range = "DateRange",
    };
};
