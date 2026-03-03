/// A structure that describes an IAM Identity Center access scope and its
/// authorized targets.
pub const ScopeDetails = struct {
    /// An array list of ARNs of applications.
    authorized_targets: ?[]const []const u8 = null,

    /// The name of the access scope.
    scope: []const u8,

    pub const json_field_names = .{
        .authorized_targets = "AuthorizedTargets",
        .scope = "Scope",
    };
};
