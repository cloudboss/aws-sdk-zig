const InstanceCountLimits = @import("instance_count_limits.zig").InstanceCountLimits;

/// InstanceLimits represents the list of instance related attributes that are
/// available for given InstanceType.
pub const InstanceLimits = struct {
    instance_count_limits: ?InstanceCountLimits = null,

    pub const json_field_names = .{
        .instance_count_limits = "InstanceCountLimits",
    };
};
