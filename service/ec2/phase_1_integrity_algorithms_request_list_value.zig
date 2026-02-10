/// Specifies the integrity algorithm for the VPN tunnel for phase 1 IKE
/// negotiations.
pub const Phase1IntegrityAlgorithmsRequestListValue = struct {
    /// The value for the integrity algorithm.
    value: ?[]const u8,
};
