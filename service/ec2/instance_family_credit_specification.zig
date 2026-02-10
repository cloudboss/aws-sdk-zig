const UnlimitedSupportedInstanceFamily = @import("unlimited_supported_instance_family.zig").UnlimitedSupportedInstanceFamily;

/// Describes the default credit option for CPU usage of a burstable performance
/// instance
/// family.
pub const InstanceFamilyCreditSpecification = struct {
    /// The default credit option for CPU usage of the instance family. Valid values
    /// are
    /// `standard` and `unlimited`.
    cpu_credits: ?[]const u8,

    /// The instance family.
    instance_family: ?UnlimitedSupportedInstanceFamily,
};
