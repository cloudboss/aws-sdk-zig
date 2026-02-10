const ReservedInstancesConfiguration = @import("reserved_instances_configuration.zig").ReservedInstancesConfiguration;

/// Describes the modification request/s.
pub const ReservedInstancesModificationResult = struct {
    /// The ID for the Reserved Instances that were created as part of the
    /// modification request.
    /// This field is only available when the modification is fulfilled.
    reserved_instances_id: ?[]const u8,

    /// The target Reserved Instances configurations supplied as part of the
    /// modification
    /// request.
    target_configuration: ?ReservedInstancesConfiguration,
};
