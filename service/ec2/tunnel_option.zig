const IKEVersionsListValue = @import("ike_versions_list_value.zig").IKEVersionsListValue;
const VpnTunnelLogOptions = @import("vpn_tunnel_log_options.zig").VpnTunnelLogOptions;
const Phase1DHGroupNumbersListValue = @import("phase_1_dh_group_numbers_list_value.zig").Phase1DHGroupNumbersListValue;
const Phase1EncryptionAlgorithmsListValue = @import("phase_1_encryption_algorithms_list_value.zig").Phase1EncryptionAlgorithmsListValue;
const Phase1IntegrityAlgorithmsListValue = @import("phase_1_integrity_algorithms_list_value.zig").Phase1IntegrityAlgorithmsListValue;
const Phase2DHGroupNumbersListValue = @import("phase_2_dh_group_numbers_list_value.zig").Phase2DHGroupNumbersListValue;
const Phase2EncryptionAlgorithmsListValue = @import("phase_2_encryption_algorithms_list_value.zig").Phase2EncryptionAlgorithmsListValue;
const Phase2IntegrityAlgorithmsListValue = @import("phase_2_integrity_algorithms_list_value.zig").Phase2IntegrityAlgorithmsListValue;

/// The VPN tunnel options.
pub const TunnelOption = struct {
    /// The action to take after a DPD timeout occurs.
    dpd_timeout_action: ?[]const u8,

    /// The number of seconds after which a DPD timeout occurs.
    dpd_timeout_seconds: ?i32,

    /// Status of tunnel endpoint lifecycle control feature.
    enable_tunnel_lifecycle_control: ?bool,

    /// The IKE versions that are permitted for the VPN tunnel.
    ike_versions: ?[]const IKEVersionsListValue,

    /// Options for logging VPN tunnel activity.
    log_options: ?VpnTunnelLogOptions,

    /// The external IP address of the VPN tunnel.
    outside_ip_address: ?[]const u8,

    /// The permitted Diffie-Hellman group numbers for the VPN tunnel for phase 1
    /// IKE
    /// negotiations.
    phase_1_dh_group_numbers: ?[]const Phase1DHGroupNumbersListValue,

    /// The permitted encryption algorithms for the VPN tunnel for phase 1 IKE
    /// negotiations.
    phase_1_encryption_algorithms: ?[]const Phase1EncryptionAlgorithmsListValue,

    /// The permitted integrity algorithms for the VPN tunnel for phase 1 IKE
    /// negotiations.
    phase_1_integrity_algorithms: ?[]const Phase1IntegrityAlgorithmsListValue,

    /// The lifetime for phase 1 of the IKE negotiation, in seconds.
    phase_1_lifetime_seconds: ?i32,

    /// The permitted Diffie-Hellman group numbers for the VPN tunnel for phase 2
    /// IKE
    /// negotiations.
    phase_2_dh_group_numbers: ?[]const Phase2DHGroupNumbersListValue,

    /// The permitted encryption algorithms for the VPN tunnel for phase 2 IKE
    /// negotiations.
    phase_2_encryption_algorithms: ?[]const Phase2EncryptionAlgorithmsListValue,

    /// The permitted integrity algorithms for the VPN tunnel for phase 2 IKE
    /// negotiations.
    phase_2_integrity_algorithms: ?[]const Phase2IntegrityAlgorithmsListValue,

    /// The lifetime for phase 2 of the IKE negotiation, in seconds.
    phase_2_lifetime_seconds: ?i32,

    /// The pre-shared key (PSK) to establish initial authentication between the
    /// virtual
    /// private gateway and the customer gateway.
    pre_shared_key: ?[]const u8,

    /// The percentage of the rekey window determined by `RekeyMarginTimeSeconds`
    /// during which the rekey time is randomly selected.
    rekey_fuzz_percentage: ?i32,

    /// The margin time, in seconds, before the phase 2 lifetime expires, during
    /// which the
    /// Amazon Web Services side of the VPN connection performs an IKE rekey.
    rekey_margin_time_seconds: ?i32,

    /// The number of packets in an IKE replay window.
    replay_window_size: ?i32,

    /// The action to take when the establishing the VPN tunnels for a VPN
    /// connection.
    startup_action: ?[]const u8,

    /// The range of inside IPv4 addresses for the tunnel.
    tunnel_inside_cidr: ?[]const u8,

    /// The range of inside IPv6 addresses for the tunnel.
    tunnel_inside_ipv_6_cidr: ?[]const u8,
};
