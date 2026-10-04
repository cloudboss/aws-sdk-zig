/// An instance type name or wildcard pattern in an instance type specification.
pub const InstanceTypeItem = struct {
    /// The instance type or wildcard pattern (for example, `t3.*` or
    /// `m5.large`).
    instance_type: ?[]const u8 = null,
};
