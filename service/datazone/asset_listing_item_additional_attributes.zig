const TimeSeriesDataPointSummaryFormOutput = @import("time_series_data_point_summary_form_output.zig").TimeSeriesDataPointSummaryFormOutput;
const MatchRationaleItem = @import("match_rationale_item.zig").MatchRationaleItem;

/// Additional attributes of an inventory asset.
pub const AssetListingItemAdditionalAttributes = struct {
    /// The metadata forms that form additional attributes of the metadata asset.
    forms: ?[]const u8 = null,

    /// The latest time series data points forms included in the additional
    /// attributes of an asset.
    latest_time_series_data_point_forms: ?[]const TimeSeriesDataPointSummaryFormOutput = null,

    /// List of rationales indicating why this item was matched by search.
    match_rationale: ?[]const MatchRationaleItem = null,

    pub const json_field_names = .{
        .forms = "forms",
        .latest_time_series_data_point_forms = "latestTimeSeriesDataPointForms",
        .match_rationale = "matchRationale",
    };
};
