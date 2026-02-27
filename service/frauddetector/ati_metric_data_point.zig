/// The Account Takeover Insights (ATI) model performance metrics data points.
pub const ATIMetricDataPoint = struct {
    /// The anomaly discovery rate. This metric quantifies the percentage of
    /// anomalies that can be detected by the model at the selected score threshold.
    /// A lower score threshold increases the percentage of anomalies captured by
    /// the model, but would also require challenging a larger percentage of
    /// login events, leading to a higher customer friction.
    adr: ?f32,

    /// The account takeover discovery rate. This metric quantifies the percentage
    /// of account compromise events that can be detected by the model at the
    /// selected score threshold.
    /// This metric is only available if 50 or more entities with at-least one
    /// labeled account takeover event is present in the ingested dataset.
    atodr: ?f32,

    /// The challenge rate. This indicates the percentage of login events that the
    /// model recommends to challenge such as
    /// one-time password, multi-factor authentication, and investigations.
    cr: ?f32,

    /// The model's threshold that specifies an acceptable fraud capture rate. For
    /// example, a threshold of 500 means any model score 500 or above is
    /// labeled as fraud.
    threshold: ?f32,

    pub const json_field_names = .{
        .adr = "adr",
        .atodr = "atodr",
        .cr = "cr",
        .threshold = "threshold",
    };
};
