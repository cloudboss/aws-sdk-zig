const SaaSProductLastModifiedDateFilterDateRange = @import("saa_s_product_last_modified_date_filter_date_range.zig").SaaSProductLastModifiedDateFilterDateRange;

/// Object that allows filtering based on the last modified date of SaaS
/// products
pub const SaaSProductLastModifiedDateFilter = struct {
    /// Dates between which the SaaS product was last modified.
    date_range: ?SaaSProductLastModifiedDateFilterDateRange,

    pub const json_field_names = .{
        .date_range = "DateRange",
    };
};
