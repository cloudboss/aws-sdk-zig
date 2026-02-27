/// Describes whether detailed monitoring is enabled for the Auto Scaling
/// instances.
pub const InstanceMonitoring = struct {
    /// If `true`, detailed monitoring is enabled. Otherwise, basic monitoring is
    /// enabled.
    enabled: ?bool,
};
