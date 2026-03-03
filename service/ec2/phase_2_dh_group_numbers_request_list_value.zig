/// Specifies a Diffie-Hellman group number for the VPN tunnel for phase 2 IKE
/// negotiations.
pub const Phase2DHGroupNumbersRequestListValue = struct {
    /// The Diffie-Hellmann group number.
    value: ?i32 = null,
};
