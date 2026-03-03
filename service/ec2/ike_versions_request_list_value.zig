/// The IKE version that is permitted for the VPN tunnel.
pub const IKEVersionsRequestListValue = struct {
    /// The IKE version.
    value: ?[]const u8 = null,
};
