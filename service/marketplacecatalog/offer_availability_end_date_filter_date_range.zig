/// Allows filtering on the `AvailabilityEndDate` of an offer with date range as
/// input.
pub const OfferAvailabilityEndDateFilterDateRange = struct {
    /// Allows filtering on the `AvailabilityEndDate` of an offer after a date.
    after_value: ?[]const u8 = null,

    /// Allows filtering on the `AvailabilityEndDate` of an offer before a date.
    before_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .after_value = "AfterValue",
        .before_value = "BeforeValue",
    };
};
