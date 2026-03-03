const ReportFrequencyType = @import("report_frequency_type.zig").ReportFrequencyType;

/// Details about how frequently reports are generated.
pub const ReportFrequency = struct {
    /// Time period between each report. The period can be daily, weekly, or
    /// monthly.
    period: ?ReportFrequencyType = null,

    /// Number of times within the frequency period that a report is generated.
    /// The only supported value is `1`.
    value: ?i32 = null,

    pub const json_field_names = .{
        .period = "period",
        .value = "value",
    };
};
