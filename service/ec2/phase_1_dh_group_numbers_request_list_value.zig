/// Specifies a Diffie-Hellman group number for the VPN tunnel for phase 1 IKE
/// negotiations.
pub const Phase1DHGroupNumbersRequestListValue = struct {
    /// The Diffie-Hellmann group number.
    value: ?i32 = null,
};
