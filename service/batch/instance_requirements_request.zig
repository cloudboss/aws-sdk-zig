/// The instance type requirements for the Amazon ECS Managed Instances capacity
/// provider. Use this
/// to specify which Amazon EC2 instance types or instance families Amazon ECS
/// can launch.
pub const InstanceRequirementsRequest = struct {
    /// A list of specific instance types or instance families that Amazon ECS can
    /// launch (for example,
    /// `m5.large` or `g5`). When specified, only these instance types are
    /// used.
    allowed_instance_types: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .allowed_instance_types = "allowedInstanceTypes",
    };
};
