/// Contains drift information for a resource property, including actual value,
/// previous
/// deployment value, and drift detection timestamp.
pub const LiveResourceDrift = struct {
    /// The current live configuration value of the resource property.
    actual_value: ?[]const u8 = null,

    /// The timestamp when drift was detected for this resource property.
    drift_detection_timestamp: ?i64 = null,

    /// The configuration value from the previous CloudFormation deployment.
    previous_value: ?[]const u8 = null,
};
