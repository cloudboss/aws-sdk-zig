/// An SSM document required by the current document.
pub const DocumentRequires = struct {
    /// The name of the required SSM document. The name can be an Amazon Resource
    /// Name (ARN).
    name: []const u8,

    /// The document type of the required SSM document.
    require_type: ?[]const u8,

    /// The document version required by the current document.
    version: ?[]const u8,

    /// An optional field specifying the version of the artifact associated with the
    /// document. For
    /// example, 12.6. This value is unique across all versions of a document, and
    /// can't be
    /// changed.
    version_name: ?[]const u8,

    pub const json_field_names = .{
        .name = "Name",
        .require_type = "RequireType",
        .version = "Version",
        .version_name = "VersionName",
    };
};
