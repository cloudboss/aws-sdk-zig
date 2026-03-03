/// The Account Takeover Insights (ATI) model performance score.
pub const ATIModelPerformance = struct {
    /// The anomaly separation index (ASI) score. This metric summarizes the overall
    /// ability of the model to separate anomalous activities from the normal
    /// behavior. Depending on the business, a
    /// large fraction of these anomalous activities can be malicious and correspond
    /// to the account takeover attacks. A model with no separability power will
    /// have the lowest possible
    /// ASI score of 0.5, whereas the a model with a high separability power will
    /// have the highest possible ASI score of 1.0
    asi: ?f32 = null,

    pub const json_field_names = .{
        .asi = "asi",
    };
};
