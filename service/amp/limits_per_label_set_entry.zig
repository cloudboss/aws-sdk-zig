/// This structure contains the information about the limits that apply to time
/// series that match one label set.
pub const LimitsPerLabelSetEntry = struct {
    /// The maximum number of active series that can be ingested that match this
    /// label set.
    ///
    /// Setting this to 0 causes no label set limit to be enforced, but it does
    /// cause Amazon Managed Service for Prometheus to vend label set metrics to
    /// CloudWatch
    max_series: ?i64,

    pub const json_field_names = .{
        .max_series = "maxSeries",
    };
};
