const TelemetryStatus = @import("telemetry_status.zig").TelemetryStatus;

/// Describes telemetry for a VPN tunnel.
pub const VgwTelemetry = struct {
    /// The number of accepted routes.
    accepted_route_count: ?i32,

    /// The Amazon Resource Name (ARN) of the VPN tunnel endpoint certificate.
    certificate_arn: ?[]const u8,

    /// The date and time of the last change in status. This field is updated when
    /// changes in IKE (Phase 1), IPSec (Phase 2), or BGP status are detected.
    last_status_change: ?i64,

    /// The Internet-routable IP address of the virtual private gateway's outside
    /// interface.
    outside_ip_address: ?[]const u8,

    /// The status of the VPN tunnel.
    status: ?TelemetryStatus,

    /// If an error occurs, a description of the error.
    status_message: ?[]const u8,
};
