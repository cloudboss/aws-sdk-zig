/// The output manifest properties reported by the worker agent for a completed
/// task run.
pub const TaskRunManifestPropertiesRequest = struct {
    /// The hash value of the file.
    output_manifest_hash: ?[]const u8,

    /// The manifest file path.
    output_manifest_path: ?[]const u8,

    pub const json_field_names = .{
        .output_manifest_hash = "outputManifestHash",
        .output_manifest_path = "outputManifestPath",
    };
};
