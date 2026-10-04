const AMISecuritySummary = @import("ami_security_summary.zig").AMISecuritySummary;
const ContainerSecuritySummary = @import("container_security_summary.zig").ContainerSecuritySummary;

/// The framework-specific details of the assessed resource. Exactly one member
/// is set,
/// corresponding to the framework that was assessed.
pub const FrameworkSummary = union(enum) {
    /// The details of the resource assessed under the AMI Security framework.
    ami_security_summary: ?AMISecuritySummary,
    /// The details of the resource assessed under the Container Security framework.
    container_security_summary: ?ContainerSecuritySummary,

    pub const json_field_names = .{
        .ami_security_summary = "AMISecuritySummary",
        .container_security_summary = "ContainerSecuritySummary",
    };
};
