const TimeSeriesIdentifiers = @import("time_series_identifiers.zig").TimeSeriesIdentifiers;

/// Defines the set of time series that are used to create the forecasts in a
/// `TimeSeriesIdentifiers` object.
///
/// The `TimeSeriesIdentifiers` object needs the following information:
///
/// * `DataSource`
///
/// * `Format`
///
/// * `Schema`
pub const TimeSeriesSelector = struct {
    /// Details about the import file that contains the time series for which you
    /// want to create forecasts.
    time_series_identifiers: ?TimeSeriesIdentifiers = null,

    pub const json_field_names = .{
        .time_series_identifiers = "TimeSeriesIdentifiers",
    };
};
