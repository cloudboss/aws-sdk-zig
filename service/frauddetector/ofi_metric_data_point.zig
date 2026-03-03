/// The Online Fraud Insights (OFI) model performance metrics data points.
pub const OFIMetricDataPoint = struct {
    /// The false positive rate. This is the percentage of total legitimate events
    /// that are incorrectly predicted as fraud.
    fpr: ?f32 = null,

    /// The percentage of fraud events correctly predicted as fraudulent as compared
    /// to all events predicted as fraudulent.
    precision: ?f32 = null,

    /// The model threshold that specifies an acceptable fraud capture rate. For
    /// example, a threshold of 500 means any model score 500 or above is labeled as
    /// fraud.
    threshold: ?f32 = null,

    /// The true positive rate. This is the percentage of total fraud the model
    /// detects. Also known as capture rate.
    tpr: ?f32 = null,

    pub const json_field_names = .{
        .fpr = "fpr",
        .precision = "precision",
        .threshold = "threshold",
        .tpr = "tpr",
    };
};
