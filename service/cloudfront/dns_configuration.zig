const DnsConfigurationStatus = @import("dns_configuration_status.zig").DnsConfigurationStatus;

/// The DNS configuration for your domain names.
pub const DnsConfiguration = struct {
    /// The domain name that you're verifying.
    domain: []const u8,

    /// Explains the status of the DNS configuration.
    reason: ?[]const u8 = null,

    /// The status of your domain name.
    ///
    /// * `valid-configuration`: The domain name is correctly configured and points
    ///   to the correct routing endpoint of the connection group.
    /// * `invalid-configuration`: There is either a missing DNS record or the DNS
    ///   record exists but it's using an incorrect routing endpoint. Update the DNS
    ///   record to point to the correct routing endpoint.
    /// * `unknown-configuration`: CloudFront can't validate your DNS configuration.
    ///   This status can appear if CloudFront can't verify the DNS record, or the
    ///   DNS lookup request failed or timed out.
    status: DnsConfigurationStatus,
};
