/// The manifest properties for a task run, corresponding to the manifest
/// properties in the job.
pub const TaskRunManifestPropertiesResponse = struct {
    /// The hash value of the file.
    output_manifest_hash: ?[]const u8,

    /// The manifest file path.
    output_manifest_path: ?[]const u8,

    pub const json_field_names = .{
        .output_manifest_hash = "outputManifestHash",
        .output_manifest_path = "outputManifestPath",
    };
};
