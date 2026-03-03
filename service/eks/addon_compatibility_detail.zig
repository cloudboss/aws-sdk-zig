/// The summary information about the Amazon EKS add-on compatibility for the
/// next Kubernetes
/// version for an insight check in the `UPGRADE_READINESS` category.
pub const AddonCompatibilityDetail = struct {
    /// The list of compatible Amazon EKS add-on versions for the next Kubernetes
    /// version.
    compatible_versions: ?[]const []const u8 = null,

    /// The name of the Amazon EKS add-on.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .compatible_versions = "compatibleVersions",
        .name = "name",
    };
};
