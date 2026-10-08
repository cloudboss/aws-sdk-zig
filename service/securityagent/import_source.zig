const SecurityRequirementArtifact = @import("security_requirement_artifact.zig").SecurityRequirementArtifact;

/// The source from which to import security requirements. Currently supports
/// document uploads.
pub const ImportSource = union(enum) {
    /// The list of documents to extract security requirements from.
    documents: ?[]const SecurityRequirementArtifact,

    pub const json_field_names = .{
        .documents = "documents",
    };
};
