const std = @import("std");

/// Specifies the time period over which environmental impact data is
/// aggregated.
pub const TimeGranularity = enum {
    /// Environmental impact data aggregated over calendar year periods
    /// (January-December).
    yearly_calendar,
    /// Environmental impact data aggregated over fiscal year periods starting from
    /// the month specified in GranularityConfiguration.FiscalYearStartMonth.
    yearly_fiscal,
    /// Environmental impact data aggregated over calendar quarter periods (Q1:
    /// Jan-Mar, Q2: Apr-Jun, Q3: Jul-Sep, Q4: Oct-Dec).
    quarterly_calendar,
    /// Environmental impact data aggregated over fiscal quarter periods based on
    /// the fiscal year start month specified in
    /// GranularityConfiguration.FiscalYearStartMonth.
    quarterly_fiscal,
    /// Environmental impact data aggregated by calendar month.
    monthly,

    pub const json_field_names = .{
        .yearly_calendar = "YEARLY_CALENDAR",
        .yearly_fiscal = "YEARLY_FISCAL",
        .quarterly_calendar = "QUARTERLY_CALENDAR",
        .quarterly_fiscal = "QUARTERLY_FISCAL",
        .monthly = "MONTHLY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .yearly_calendar => "YEARLY_CALENDAR",
            .yearly_fiscal => "YEARLY_FISCAL",
            .quarterly_calendar => "QUARTERLY_CALENDAR",
            .quarterly_fiscal => "QUARTERLY_FISCAL",
            .monthly => "MONTHLY",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
