const SecurityRequirementArtifactFormat = @import("security_requirement_artifact_format.zig").SecurityRequirementArtifactFormat;

/// A document used as source material for importing security requirements.
pub const SecurityRequirementArtifact = struct {
    /// The binary content of the document.
    content: []const u8,

    /// The format of the document. Valid values are MD, PDF, TXT, DOCX, and DOC.
    format: SecurityRequirementArtifactFormat,

    /// The file name of the document.
    name: []const u8,

    pub const json_field_names = .{
        .content = "content",
        .format = "format",
        .name = "name",
    };
};
