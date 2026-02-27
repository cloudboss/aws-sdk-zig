const MitigationInEffectEnum = @import("mitigation_in_effect_enum.zig").MitigationInEffectEnum;
const AnomalyResultEnum = @import("anomaly_result_enum.zig").AnomalyResultEnum;

/// Information about anomaly detection and mitigation.
pub const AnomalyDetection = struct {
    /// Indicates whether anomaly mitigation is in progress.
    mitigation_in_effect: ?MitigationInEffectEnum,

    /// The latest anomaly detection result.
    result: ?AnomalyResultEnum,
};
