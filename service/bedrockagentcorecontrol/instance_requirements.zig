/// The requirements for Amazon EC2 instance types in a capacity provider.
pub const InstanceRequirements = struct {
    /// The list of allowed instance types. You can specify up to 30 instance types.
    allowed_instance_types: []const []const u8,

    pub const json_field_names = .{
        .allowed_instance_types = "allowedInstanceTypes",
    };
};
