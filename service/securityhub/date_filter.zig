const DateRange = @import("date_range.zig").DateRange;

/// A date filter for querying findings.
pub const DateFilter = struct {
    /// A date range for the date filter.
    date_range: ?DateRange,

    /// A timestamp that provides the end date for the date filter.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    end: ?[]const u8,

    /// A timestamp that provides the start date for the date filter.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    start: ?[]const u8,

    pub const json_field_names = .{
        .date_range = "DateRange",
        .end = "End",
        .start = "Start",
    };
};
