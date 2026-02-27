/// The VPN tunnel options.
pub const AwsEc2VpnConnectionOptionsTunnelOptionsDetails = struct {
    /// The number of seconds after which a Dead Peer Detection (DPD) timeout
    /// occurs.
    dpd_timeout_seconds: ?i32,

    /// The Internet Key Exchange (IKE) versions that are permitted for the VPN
    /// tunnel.
    ike_versions: ?[]const []const u8,

    /// The external IP address of the VPN tunnel.
    outside_ip_address: ?[]const u8,

    /// The permitted Diffie-Hellman group numbers for the VPN tunnel for phase 1
    /// IKE
    /// negotiations.
    phase_1_dh_group_numbers: ?[]const i32,

    /// The permitted encryption algorithms for the VPN tunnel for phase 1 IKE
    /// negotiations.
    phase_1_encryption_algorithms: ?[]const []const u8,

    /// The permitted integrity algorithms for the VPN tunnel for phase 1 IKE
    /// negotiations.
    phase_1_integrity_algorithms: ?[]const []const u8,

    /// The lifetime for phase 1 of the IKE negotiation, in seconds.
    phase_1_lifetime_seconds: ?i32,

    /// The permitted Diffie-Hellman group numbers for the VPN tunnel for phase 2
    /// IKE
    /// negotiations.
    phase_2_dh_group_numbers: ?[]const i32,

    /// The permitted encryption algorithms for the VPN tunnel for phase 2 IKE
    /// negotiations.
    phase_2_encryption_algorithms: ?[]const []const u8,

    /// The permitted integrity algorithms for the VPN tunnel for phase 2 IKE
    /// negotiations.
    phase_2_integrity_algorithms: ?[]const []const u8,

    /// The lifetime for phase 2 of the IKE negotiation, in seconds.
    phase_2_lifetime_seconds: ?i32,

    /// The preshared key to establish initial authentication between the virtual
    /// private gateway
    /// and the customer gateway.
    pre_shared_key: ?[]const u8,

    /// The percentage of the rekey window, which is determined by
    /// `RekeyMarginTimeSeconds` during which the rekey time is randomly selected.
    rekey_fuzz_percentage: ?i32,

    /// The margin time, in seconds, before the phase 2 lifetime expires, during
    /// which the Amazon Web Services
    /// side of the VPN connection performs an IKE rekey.
    rekey_margin_time_seconds: ?i32,

    /// The number of packets in an IKE replay window.
    replay_window_size: ?i32,

    /// The range of inside IPv4 addresses for the tunnel.
    tunnel_inside_cidr: ?[]const u8,

    pub const json_field_names = .{
        .dpd_timeout_seconds = "DpdTimeoutSeconds",
        .ike_versions = "IkeVersions",
        .outside_ip_address = "OutsideIpAddress",
        .phase_1_dh_group_numbers = "Phase1DhGroupNumbers",
        .phase_1_encryption_algorithms = "Phase1EncryptionAlgorithms",
        .phase_1_integrity_algorithms = "Phase1IntegrityAlgorithms",
        .phase_1_lifetime_seconds = "Phase1LifetimeSeconds",
        .phase_2_dh_group_numbers = "Phase2DhGroupNumbers",
        .phase_2_encryption_algorithms = "Phase2EncryptionAlgorithms",
        .phase_2_integrity_algorithms = "Phase2IntegrityAlgorithms",
        .phase_2_lifetime_seconds = "Phase2LifetimeSeconds",
        .pre_shared_key = "PreSharedKey",
        .rekey_fuzz_percentage = "RekeyFuzzPercentage",
        .rekey_margin_time_seconds = "RekeyMarginTimeSeconds",
        .replay_window_size = "ReplayWindowSize",
        .tunnel_inside_cidr = "TunnelInsideCidr",
    };
};
