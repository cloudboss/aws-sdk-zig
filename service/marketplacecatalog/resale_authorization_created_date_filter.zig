const ResaleAuthorizationCreatedDateFilterDateRange = @import("resale_authorization_created_date_filter_date_range.zig").ResaleAuthorizationCreatedDateFilterDateRange;

/// Allows filtering on `CreatedDate` of a ResaleAuthorization.
pub const ResaleAuthorizationCreatedDateFilter = struct {
    /// Allows filtering on `CreatedDate` of a ResaleAuthorization with date range
    /// as input.
    date_range: ?ResaleAuthorizationCreatedDateFilterDateRange = null,

    /// Allows filtering on `CreatedDate` of a ResaleAuthorization with date value
    /// as input.
    value_list: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .date_range = "DateRange",
        .value_list = "ValueList",
    };
};
