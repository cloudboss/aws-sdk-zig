const IKEVersionsRequestListValue = @import("ike_versions_request_list_value.zig").IKEVersionsRequestListValue;
const VpnTunnelLogOptionsSpecification = @import("vpn_tunnel_log_options_specification.zig").VpnTunnelLogOptionsSpecification;
const Phase1DHGroupNumbersRequestListValue = @import("phase_1_dh_group_numbers_request_list_value.zig").Phase1DHGroupNumbersRequestListValue;
const Phase1EncryptionAlgorithmsRequestListValue = @import("phase_1_encryption_algorithms_request_list_value.zig").Phase1EncryptionAlgorithmsRequestListValue;
const Phase1IntegrityAlgorithmsRequestListValue = @import("phase_1_integrity_algorithms_request_list_value.zig").Phase1IntegrityAlgorithmsRequestListValue;
const Phase2DHGroupNumbersRequestListValue = @import("phase_2_dh_group_numbers_request_list_value.zig").Phase2DHGroupNumbersRequestListValue;
const Phase2EncryptionAlgorithmsRequestListValue = @import("phase_2_encryption_algorithms_request_list_value.zig").Phase2EncryptionAlgorithmsRequestListValue;
const Phase2IntegrityAlgorithmsRequestListValue = @import("phase_2_integrity_algorithms_request_list_value.zig").Phase2IntegrityAlgorithmsRequestListValue;

/// The tunnel options for a single VPN tunnel.
pub const VpnTunnelOptionsSpecification = struct {
    /// The action to take after DPD timeout occurs. Specify `restart` to restart
    /// the IKE initiation. Specify `clear` to end the IKE session.
    ///
    /// Valid Values: `clear` | `none` | `restart`
    ///
    /// Default: `clear`
    dpd_timeout_action: ?[]const u8 = null,

    /// The number of seconds after which a DPD timeout occurs.
    ///
    /// Constraints: A value greater than or equal to 30.
    ///
    /// Default: `30`
    dpd_timeout_seconds: ?i32 = null,

    /// Turn on or off tunnel endpoint lifecycle control feature.
    enable_tunnel_lifecycle_control: ?bool = null,

    /// The IKE versions that are permitted for the VPN tunnel.
    ///
    /// Valid values: `ikev1` | `ikev2`
    ike_versions: ?[]const IKEVersionsRequestListValue = null,

    /// Options for logging VPN tunnel activity.
    log_options: ?VpnTunnelLogOptionsSpecification = null,

    /// One or more Diffie-Hellman group numbers that are permitted for the VPN
    /// tunnel for
    /// phase 1 IKE negotiations.
    ///
    /// Valid values: `2` | `14` | `15` | `16` |
    /// `17` | `18` | `19` | `20` |
    /// `21` | `22` | `23` | `24`
    phase_1_dh_group_numbers: ?[]const Phase1DHGroupNumbersRequestListValue = null,

    /// One or more encryption algorithms that are permitted for the VPN tunnel for
    /// phase 1
    /// IKE negotiations.
    ///
    /// Valid values: `AES128` | `AES256` | `AES128-GCM-16` |
    /// `AES256-GCM-16`
    phase_1_encryption_algorithms: ?[]const Phase1EncryptionAlgorithmsRequestListValue = null,

    /// One or more integrity algorithms that are permitted for the VPN tunnel for
    /// phase 1 IKE
    /// negotiations.
    ///
    /// Valid values: `SHA1` | `SHA2-256` | `SHA2-384` |
    /// `SHA2-512`
    phase_1_integrity_algorithms: ?[]const Phase1IntegrityAlgorithmsRequestListValue = null,

    /// The lifetime for phase 1 of the IKE negotiation, in seconds.
    ///
    /// Constraints: A value between 900 and 28,800.
    ///
    /// Default: `28800`
    phase_1_lifetime_seconds: ?i32 = null,

    /// One or more Diffie-Hellman group numbers that are permitted for the VPN
    /// tunnel for
    /// phase 2 IKE negotiations.
    ///
    /// Valid values: `2` | `5` | `14` | `15` |
    /// `16` | `17` | `18` | `19` |
    /// `20` | `21` | `22` | `23` |
    /// `24`
    phase_2_dh_group_numbers: ?[]const Phase2DHGroupNumbersRequestListValue = null,

    /// One or more encryption algorithms that are permitted for the VPN tunnel for
    /// phase 2
    /// IKE negotiations.
    ///
    /// Valid values: `AES128` | `AES256` | `AES128-GCM-16` |
    /// `AES256-GCM-16`
    phase_2_encryption_algorithms: ?[]const Phase2EncryptionAlgorithmsRequestListValue = null,

    /// One or more integrity algorithms that are permitted for the VPN tunnel for
    /// phase 2 IKE
    /// negotiations.
    ///
    /// Valid values: `SHA1` | `SHA2-256` | `SHA2-384` |
    /// `SHA2-512`
    phase_2_integrity_algorithms: ?[]const Phase2IntegrityAlgorithmsRequestListValue = null,

    /// The lifetime for phase 2 of the IKE negotiation, in seconds.
    ///
    /// Constraints: A value between 900 and 3,600. The value must be less than the
    /// value for
    /// `Phase1LifetimeSeconds`.
    ///
    /// Default: `3600`
    phase_2_lifetime_seconds: ?i32 = null,

    /// The pre-shared key (PSK) to establish initial authentication between the
    /// virtual
    /// private gateway and customer gateway.
    ///
    /// Constraints: Allowed characters are alphanumeric characters, periods (.),
    /// and
    /// underscores (_). Must be between 8 and 64 characters in length and cannot
    /// start with
    /// zero (0).
    pre_shared_key: ?[]const u8 = null,

    /// The percentage of the rekey window (determined by `RekeyMarginTimeSeconds`)
    /// during which the rekey time is randomly selected.
    ///
    /// Constraints: A value between 0 and 100.
    ///
    /// Default: `100`
    rekey_fuzz_percentage: ?i32 = null,

    /// The margin time, in seconds, before the phase 2 lifetime expires, during
    /// which the
    /// Amazon Web Services side of the VPN connection performs an IKE rekey. The
    /// exact time
    /// of the rekey is randomly selected based on the value for
    /// `RekeyFuzzPercentage`.
    ///
    /// Constraints: A value between 60 and half of `Phase2LifetimeSeconds`.
    ///
    /// Default: `270`
    rekey_margin_time_seconds: ?i32 = null,

    /// The number of packets in an IKE replay window.
    ///
    /// Constraints: A value between 64 and 2048.
    ///
    /// Default: `1024`
    replay_window_size: ?i32 = null,

    /// The action to take when the establishing the tunnel for the VPN connection.
    /// By
    /// default, your customer gateway device must initiate the IKE negotiation and
    /// bring up the
    /// tunnel. Specify `start` for Amazon Web Services to initiate the IKE
    /// negotiation.
    ///
    /// Valid Values: `add` | `start`
    ///
    /// Default: `add`
    startup_action: ?[]const u8 = null,

    /// The range of inside IPv4 addresses for the tunnel. Any specified CIDR blocks
    /// must be
    /// unique across all VPN connections that use the same virtual private gateway.
    ///
    /// Constraints: A size /30 CIDR block from the `169.254.0.0/16` range. The
    /// following CIDR blocks are reserved and cannot be used:
    ///
    /// * `169.254.0.0/30`
    ///
    /// * `169.254.1.0/30`
    ///
    /// * `169.254.2.0/30`
    ///
    /// * `169.254.3.0/30`
    ///
    /// * `169.254.4.0/30`
    ///
    /// * `169.254.5.0/30`
    ///
    /// * `169.254.169.252/30`
    tunnel_inside_cidr: ?[]const u8 = null,

    /// The range of inside IPv6 addresses for the tunnel. Any specified CIDR blocks
    /// must be
    /// unique across all VPN connections that use the same transit gateway.
    ///
    /// Constraints: A size /126 CIDR block from the local `fd00::/8` range.
    tunnel_inside_ipv_6_cidr: ?[]const u8 = null,
};
