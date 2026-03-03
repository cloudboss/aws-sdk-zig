const InstanceResizePolicy = @import("instance_resize_policy.zig").InstanceResizePolicy;

/// Policy for customizing shrink operations. Allows configuration of
/// decommissioning
/// timeout and targeted instance shrinking.
pub const ShrinkPolicy = struct {
    /// The desired timeout for decommissioning an instance. Overrides the default
    /// YARN
    /// decommissioning timeout.
    decommission_timeout: ?i32 = null,

    /// Custom policy for requesting termination protection or termination of
    /// specific instances
    /// when shrinking an instance group.
    instance_resize_policy: ?InstanceResizePolicy = null,

    pub const json_field_names = .{
        .decommission_timeout = "DecommissionTimeout",
        .instance_resize_policy = "InstanceResizePolicy",
    };
};
