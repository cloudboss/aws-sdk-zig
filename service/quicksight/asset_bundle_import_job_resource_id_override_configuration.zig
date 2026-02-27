/// An optional structure that configures resource ID overrides for the import
/// job.
pub const AssetBundleImportJobResourceIdOverrideConfiguration = struct {
    /// An option to request a CloudFormation variable for a prefix to be prepended
    /// to each
    /// resource's ID before import. The prefix is only added to the asset IDs and
    /// does not
    /// change the name of the asset.
    prefix_for_all_resources: ?[]const u8,

    pub const json_field_names = .{
        .prefix_for_all_resources = "PrefixForAllResources",
    };
};
