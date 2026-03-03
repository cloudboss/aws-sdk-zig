const InstanceCountLimits = @import("instance_count_limits.zig").InstanceCountLimits;

/// Instance-related attributes that are available for a given instance type.
pub const InstanceLimits = struct {
    /// Limits on the number of instances that can be created for a given instance
    /// type.
    instance_count_limits: ?InstanceCountLimits = null,

    pub const json_field_names = .{
        .instance_count_limits = "InstanceCountLimits",
    };
};
