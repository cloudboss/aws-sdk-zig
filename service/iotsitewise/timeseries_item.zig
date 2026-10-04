const FormatSettings = @import("format_settings.zig").FormatSettings;
const TrimSettings = @import("trim_settings.zig").TrimSettings;

/// A single timeseries item to process. Exactly one of timeSeriesId or
/// propertyAlias must be provided.
pub const TimeseriesItem = struct {
    /// The optional format settings for the output.
    format_settings: ?FormatSettings = null,

    /// The customer-friendly alias for the timeseries. Mutually exclusive with
    /// timeSeriesId.
    property_alias: ?[]const u8 = null,

    /// The unique identifier for the timeseries. Mutually exclusive with
    /// propertyAlias.
    time_series_id: ?[]const u8 = null,

    /// The trim settings for the time range to export. Required for VIDEO and
    /// TELEMETRY data types; optional for ANNOTATION data types.
    trim_settings: ?TrimSettings = null,

    pub const json_field_names = .{
        .format_settings = "formatSettings",
        .property_alias = "propertyAlias",
        .time_series_id = "timeSeriesId",
        .trim_settings = "trimSettings",
    };
};
