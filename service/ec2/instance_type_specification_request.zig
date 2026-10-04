/// The instance type specification for an AMI, which contains lists of
/// supported and
/// unsupported instance types that define which instance types are compatible
/// with the AMI.
pub const InstanceTypeSpecificationRequest = struct {
    /// The instance types that the AMI supports. You can specify instance type
    /// names or use
    /// wildcard patterns (for example, `t3.*`).
    ///
    /// Constraints: Maximum 100 entries. Each entry must be 1-24 characters and
    /// match the pattern
    /// `^[A-Za-z0-9_.*-]+$`. Consecutive wildcard characters (`**`) are not
    /// allowed. Entries must be unique within each list and across both lists;
    /// duplicate entries cause the request to fail.
    supported_instance_types: ?[]const []const u8 = null,

    /// The instance types that the AMI does not support. You can specify instance
    /// type names or
    /// use wildcard patterns (for example, `t3.*`).
    ///
    /// Constraints: Maximum 100 entries. Each entry must be 1-24 characters and
    /// match the pattern
    /// `^[A-Za-z0-9_.*-]+$`. Consecutive wildcard characters (`**`) are not
    /// allowed. Entries must be unique within each list and across both lists;
    /// duplicate entries cause the request to fail.
    unsupported_instance_types: ?[]const []const u8 = null,
};
