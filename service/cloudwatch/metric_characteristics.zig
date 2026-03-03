/// This object includes parameters that you can use to provide information to
/// CloudWatch to help it build more accurate anomaly detection models.
pub const MetricCharacteristics = struct {
    /// Set this parameter to `true` if values for this metric consistently include
    /// spikes that should not be considered to be anomalies. With this set to
    /// `true`, CloudWatch will expect to see spikes that occurred
    /// consistently during the model training period, and won't flag future similar
    /// spikes as
    /// anomalies.
    periodic_spikes: ?bool = null,

    pub const json_field_names = .{
        .periodic_spikes = "PeriodicSpikes",
    };
};
