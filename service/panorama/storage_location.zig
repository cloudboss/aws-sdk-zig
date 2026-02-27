/// A storage location.
pub const StorageLocation = struct {
    /// The location's binary prefix.
    binary_prefix_location: []const u8,

    /// The location's bucket.
    bucket: []const u8,

    /// The location's generated prefix.
    generated_prefix_location: []const u8,

    /// The location's manifest prefix.
    manifest_prefix_location: []const u8,

    /// The location's repo prefix.
    repo_prefix_location: []const u8,

    pub const json_field_names = .{
        .binary_prefix_location = "BinaryPrefixLocation",
        .bucket = "Bucket",
        .generated_prefix_location = "GeneratedPrefixLocation",
        .manifest_prefix_location = "ManifestPrefixLocation",
        .repo_prefix_location = "RepoPrefixLocation",
    };
};
