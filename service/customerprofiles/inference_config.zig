/// Configuration settings for inference behavior of the recommender.
pub const InferenceConfig = struct {
    /// The minimum provisioned transactions per second (TPS) that the recommender
    /// supports. The default value is 1. A high MinProvisionedTPS will increase
    /// your cost.
    min_provisioned_tps: ?i32 = null,

    pub const json_field_names = .{
        .min_provisioned_tps = "MinProvisionedTPS",
    };
};
