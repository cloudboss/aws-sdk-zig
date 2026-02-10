/// Specifies the integrity algorithm for the VPN tunnel for phase 2 IKE
/// negotiations.
pub const Phase2IntegrityAlgorithmsRequestListValue = struct {
    /// The integrity algorithm.
    value: ?[]const u8,
};
