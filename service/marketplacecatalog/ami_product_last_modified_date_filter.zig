const AmiProductLastModifiedDateFilterDateRange = @import("ami_product_last_modified_date_filter_date_range.zig").AmiProductLastModifiedDateFilterDateRange;

/// Object that allows filtering based on the last modified date of AMI
/// products.
pub const AmiProductLastModifiedDateFilter = struct {
    /// Dates between which the AMI product was last modified.
    date_range: ?AmiProductLastModifiedDateFilterDateRange = null,

    pub const json_field_names = .{
        .date_range = "DateRange",
    };
};
