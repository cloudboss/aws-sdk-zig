const ATITrainingMetricsValue = @import("ati_training_metrics_value.zig").ATITrainingMetricsValue;
const OFITrainingMetricsValue = @import("ofi_training_metrics_value.zig").OFITrainingMetricsValue;
const TFITrainingMetricsValue = @import("tfi_training_metrics_value.zig").TFITrainingMetricsValue;

/// The training metrics details.
pub const TrainingMetricsV2 = struct {
    /// The Account Takeover Insights (ATI) model training metric details.
    ati: ?ATITrainingMetricsValue = null,

    /// The Online Fraud Insights (OFI) model training metric details.
    ofi: ?OFITrainingMetricsValue = null,

    /// The Transaction Fraud Insights (TFI) model training metric details.
    tfi: ?TFITrainingMetricsValue = null,

    pub const json_field_names = .{
        .ati = "ati",
        .ofi = "ofi",
        .tfi = "tfi",
    };
};
