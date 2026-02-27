const ResaleAuthorizationLastModifiedDateFilterDateRange = @import("resale_authorization_last_modified_date_filter_date_range.zig").ResaleAuthorizationLastModifiedDateFilterDateRange;

/// Allows filtering on the `LastModifiedDate` of a ResaleAuthorization.
pub const ResaleAuthorizationLastModifiedDateFilter = struct {
    /// Allows filtering on the `LastModifiedDate` of a ResaleAuthorization with
    /// date range as input.
    date_range: ?ResaleAuthorizationLastModifiedDateFilterDateRange,

    pub const json_field_names = .{
        .date_range = "DateRange",
    };
};
