/// Defines the mapping between an in-app role and the Amazon Web Services IAM
/// Identity Center group patterns that should be assigned to that role within
/// the SageMaker Partner AI App.
pub const RoleGroupAssignment = struct {
    /// A list of Amazon Web Services IAM Identity Center group patterns that should
    /// be assigned to the specified role. Group patterns support wildcard matching
    /// using `*`.
    group_patterns: []const []const u8,

    /// The name of the in-app role within the SageMaker Partner AI App. The
    /// specific roles available depend on the app type and version.
    role_name: []const u8,

    pub const json_field_names = .{
        .group_patterns = "GroupPatterns",
        .role_name = "RoleName",
    };
};
