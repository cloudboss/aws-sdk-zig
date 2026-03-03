/// Information about the VPN tunnel.
pub const AwsEc2VpnConnectionVgwTelemetryDetails = struct {
    /// The number of accepted routes.
    accepted_route_count: ?i32 = null,

    /// The ARN of the VPN tunnel endpoint certificate.
    certificate_arn: ?[]const u8 = null,

    /// The date and time of the last change in status.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    last_status_change: ?[]const u8 = null,

    /// The Internet-routable IP address of the virtual private gateway's outside
    /// interface.
    outside_ip_address: ?[]const u8 = null,

    /// The status of the VPN tunnel. Valid values are `DOWN` or `UP`.
    status: ?[]const u8 = null,

    /// If an error occurs, a description of the error.
    status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .accepted_route_count = "AcceptedRouteCount",
        .certificate_arn = "CertificateArn",
        .last_status_change = "LastStatusChange",
        .outside_ip_address = "OutsideIpAddress",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};
