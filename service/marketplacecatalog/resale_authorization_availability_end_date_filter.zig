const ResaleAuthorizationAvailabilityEndDateFilterDateRange = @import("resale_authorization_availability_end_date_filter_date_range.zig").ResaleAuthorizationAvailabilityEndDateFilterDateRange;

/// Allows filtering on `AvailabilityEndDate` of a ResaleAuthorization.
pub const ResaleAuthorizationAvailabilityEndDateFilter = struct {
    /// Allows filtering on `AvailabilityEndDate` of a ResaleAuthorization with date
    /// range as input
    date_range: ?ResaleAuthorizationAvailabilityEndDateFilterDateRange,

    /// Allows filtering on `AvailabilityEndDate` of a ResaleAuthorization with date
    /// value as input.
    value_list: ?[]const []const u8,

    pub const json_field_names = .{
        .date_range = "DateRange",
        .value_list = "ValueList",
    };
};
