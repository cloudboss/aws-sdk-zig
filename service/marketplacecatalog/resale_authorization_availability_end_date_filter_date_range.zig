/// Allows filtering on `AvailabilityEndDate` of a ResaleAuthorization with date
/// range as input.
pub const ResaleAuthorizationAvailabilityEndDateFilterDateRange = struct {
    /// Allows filtering on `AvailabilityEndDate` of a ResaleAuthorization after a
    /// date.
    after_value: ?[]const u8,

    /// Allows filtering on `AvailabilityEndDate` of a ResaleAuthorization before a
    /// date.
    before_value: ?[]const u8,

    pub const json_field_names = .{
        .after_value = "AfterValue",
        .before_value = "BeforeValue",
    };
};
