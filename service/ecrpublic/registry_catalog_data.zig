/// The metadata for a public registry.
pub const RegistryCatalogData = struct {
    /// The display name for a public registry. This appears on the Amazon ECR
    /// Public Gallery.
    ///
    /// Only accounts that have the verified account badge can have a registry
    /// display
    /// name.
    display_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .display_name = "displayName",
    };
};
