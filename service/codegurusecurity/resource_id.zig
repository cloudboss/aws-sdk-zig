/// The identifier for a resource object that contains resources to scan.
/// Specifying a codeArtifactId is required to create a scan.
pub const ResourceId = union(enum) {
    /// The identifier for the code file uploaded to the resource object. Returned
    /// by `CreateUploadUrl` when you upload resources to be scanned.
    code_artifact_id: ?[]const u8,

    pub const json_field_names = .{
        .code_artifact_id = "codeArtifactId",
    };
};
