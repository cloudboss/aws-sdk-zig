const Tag = @import("tag.zig").Tag;

/// An object that contains a list of tags to be assigned to a list of VPC
/// connection
/// IDs.
pub const AssetBundleImportJobVPCConnectionOverrideTags = struct {
    /// A list of tags for the VPC connections that you want to apply overrides to.
    tags: []const Tag,

    /// A list of VPC connection IDs that you want to apply overrides to. You can
    /// use
    /// `*` to override all VPC connections in this asset bundle.
    vpc_connection_ids: []const []const u8,

    pub const json_field_names = .{
        .tags = "Tags",
        .vpc_connection_ids = "VPCConnectionIds",
    };
};
