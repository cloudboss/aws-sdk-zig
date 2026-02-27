/// Specifies UDP configuration for ENA SRD.
pub const EnaSrdUdpSpecificationRequest = struct {
    /// Enables or disables ENA SRD for UDP traffic.
    ena_srd_udp_enabled: ?bool,

    pub const json_field_names = .{
        .ena_srd_udp_enabled = "EnaSrdUdpEnabled",
    };
};
