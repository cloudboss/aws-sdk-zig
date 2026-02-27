/// Information about the versioning of dataset contents.
pub const VersioningConfiguration = struct {
    /// How many versions of dataset contents are kept. The `unlimited` parameter
    /// must
    /// be `false`.
    max_versions: ?i32,

    /// If true, unlimited versions of dataset contents are kept.
    unlimited: bool = false,

    pub const json_field_names = .{
        .max_versions = "maxVersions",
        .unlimited = "unlimited",
    };
};
