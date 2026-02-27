/// A structure that contains the permissions for the resource that you want to
/// override in
/// an asset bundle import job.
pub const AssetBundleResourcePermissions = struct {
    /// A list of IAM actions to grant permissions on.
    actions: []const []const u8,

    /// A list of principals to grant permissions on.
    principals: []const []const u8,

    pub const json_field_names = .{
        .actions = "Actions",
        .principals = "Principals",
    };
};
