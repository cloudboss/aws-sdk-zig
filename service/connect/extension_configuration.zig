const AllowedExtension = @import("allowed_extension.zig").AllowedExtension;

/// The configuration for allowed file extensions.
pub const ExtensionConfiguration = struct {
    /// The list of allowed file extensions.
    allowed_extensions: []const AllowedExtension,

    pub const json_field_names = .{
        .allowed_extensions = "AllowedExtensions",
    };
};
