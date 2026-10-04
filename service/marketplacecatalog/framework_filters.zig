const AMISecurityFilters = @import("ami_security_filters.zig").AMISecurityFilters;
const ContainerSecurityFilters = @import("container_security_filters.zig").ContainerSecurityFilters;

/// Framework-specific filters used to scope `ListAssessments` results. Set
/// exactly one member, corresponding to the framework you want to filter by.
pub const FrameworkFilters = union(enum) {
    /// Filters that apply to assessments performed against the AMI Security
    /// framework.
    ami_security_filters: ?AMISecurityFilters,
    /// Filters that apply to assessments performed against the Container Security
    /// framework.
    container_security_filters: ?ContainerSecurityFilters,

    pub const json_field_names = .{
        .ami_security_filters = "AMISecurityFilters",
        .container_security_filters = "ContainerSecurityFilters",
    };
};
