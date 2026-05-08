/// Information about an allowed file extension.
pub const AllowedExtension = struct {
    /// The file extension. The extension must be between 1 and 10 characters and
    /// can contain only alphanumeric characters, hyphens, and underscores.
    extension: []const u8,

    pub const json_field_names = .{
        .extension = "Extension",
    };
};
