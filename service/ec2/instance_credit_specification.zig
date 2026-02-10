/// Describes the credit option for CPU usage of a burstable performance
/// instance.
pub const InstanceCreditSpecification = struct {
    /// The credit option for CPU usage of the instance.
    ///
    /// Valid values: `standard` | `unlimited`
    cpu_credits: ?[]const u8,

    /// The ID of the instance.
    instance_id: ?[]const u8,
};
