const IpamDiscoveryFailureCode = @import("ipam_discovery_failure_code.zig").IpamDiscoveryFailureCode;

/// The discovery failure reason.
pub const IpamDiscoveryFailureReason = struct {
    /// The discovery failure code.
    ///
    /// * `assume-role-failure` - IPAM could not assume the Amazon Web Services IAM
    ///   service-linked role. This could be because of any of the following:
    ///
    /// * SLR has not been created yet and IPAM is still creating it.
    ///
    /// * You have opted-out of the IPAM home Region.
    ///
    /// * Account you are using as your IPAM account has been suspended.
    ///
    /// * `throttling-failure` - IPAM account is already using the allotted
    ///   transactions per second and IPAM is receiving a throttling error when
    ///   assuming the Amazon Web Services IAM SLR.
    ///
    /// * `unauthorized-failure` - Amazon Web Services account making the request is
    ///   not authorized. For more information, see
    ///   [AuthFailure](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/errors-overview.html) in the *Amazon Elastic Compute Cloud API Reference*.
    code: ?IpamDiscoveryFailureCode,

    /// The discovery failure message.
    message: ?[]const u8,
};
