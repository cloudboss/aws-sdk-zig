const FormOutput = @import("form_output.zig").FormOutput;
const TimeSeriesDataPointSummaryFormOutput = @import("time_series_data_point_summary_form_output.zig").TimeSeriesDataPointSummaryFormOutput;
const MatchRationaleItem = @import("match_rationale_item.zig").MatchRationaleItem;

/// The additional attributes of an inventory asset.
pub const AssetItemAdditionalAttributes = struct {
    /// The forms included in the additional attributes of an inventory asset.
    forms_output: ?[]const FormOutput = null,

    /// The latest time series data points forms included in the additional
    /// attributes of an asset.
    latest_time_series_data_point_forms_output: ?[]const TimeSeriesDataPointSummaryFormOutput = null,

    /// List of rationales indicating why this item was matched by search.
    match_rationale: ?[]const MatchRationaleItem = null,

    /// The read-only forms included in the additional attributes of an inventory
    /// asset.
    read_only_forms_output: ?[]const FormOutput = null,

    pub const json_field_names = .{
        .forms_output = "formsOutput",
        .latest_time_series_data_point_forms_output = "latestTimeSeriesDataPointFormsOutput",
        .match_rationale = "matchRationale",
        .read_only_forms_output = "readOnlyFormsOutput",
    };
};
