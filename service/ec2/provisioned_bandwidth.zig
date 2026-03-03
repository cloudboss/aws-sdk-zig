/// Reserved. If you need to sustain traffic greater than the [documented
/// limits](https://docs.aws.amazon.com/vpc/latest/userguide/amazon-vpc-limits.html#vpc-limits-gateways),
/// contact Amazon Web Services Support.
pub const ProvisionedBandwidth = struct {
    /// Reserved.
    provisioned: ?[]const u8 = null,

    /// Reserved.
    provision_time: ?i64 = null,

    /// Reserved.
    requested: ?[]const u8 = null,

    /// Reserved.
    request_time: ?i64 = null,

    /// Reserved.
    status: ?[]const u8 = null,
};
