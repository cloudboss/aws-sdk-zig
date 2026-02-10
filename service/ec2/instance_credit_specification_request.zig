/// Describes the credit option for CPU usage of a burstable performance
/// instance.
pub const InstanceCreditSpecificationRequest = struct {
    /// The credit option for CPU usage of the instance.
    ///
    /// Valid values: `standard` | `unlimited`
    ///
    /// T3 instances with `host` tenancy do not support the `unlimited`
    /// CPU credit option.
    cpu_credits: ?[]const u8,

    /// The ID of the instance.
    instance_id: []const u8,
};
