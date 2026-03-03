const Architecture = @import("architecture.zig").Architecture;

/// Specifications that define the characteristics and constraints for compute
/// instances used by the capacity provider.
pub const InstanceRequirements = struct {
    /// A list of EC2 instance types that the capacity provider is allowed to use.
    /// If not specified, all compatible instance types are allowed.
    allowed_instance_types: ?[]const []const u8 = null,

    /// A list of supported CPU architectures for compute instances. Valid values
    /// include `x86_64` and `arm64`.
    architectures: ?[]const Architecture = null,

    /// A list of EC2 instance types that the capacity provider should not use, even
    /// if they meet other requirements.
    excluded_instance_types: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .allowed_instance_types = "AllowedInstanceTypes",
        .architectures = "Architectures",
        .excluded_instance_types = "ExcludedInstanceTypes",
    };
};
