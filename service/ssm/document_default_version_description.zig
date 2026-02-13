/// A default version of a document.
pub const DocumentDefaultVersionDescription = struct {
    /// The default version of the document.
    default_version: ?[]const u8,

    /// The default version of the artifact associated with the document.
    default_version_name: ?[]const u8,

    /// The name of the document.
    name: ?[]const u8,

    pub const json_field_names = .{
        .default_version = "DefaultVersion",
        .default_version_name = "DefaultVersionName",
        .name = "Name",
    };
};
