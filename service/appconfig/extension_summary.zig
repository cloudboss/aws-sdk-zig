/// Information about an extension. Call `GetExtension` to get more information
/// about an extension.
pub const ExtensionSummary = struct {
    /// The system-generated Amazon Resource Name (ARN) for the extension.
    arn: ?[]const u8 = null,

    /// Information about the extension.
    description: ?[]const u8 = null,

    /// The system-generated ID of the extension.
    id: ?[]const u8 = null,

    /// The extension name.
    name: ?[]const u8 = null,

    /// The extension version number.
    version_number: i32 = 0,

    pub const json_field_names = .{
        .arn = "Arn",
        .description = "Description",
        .id = "Id",
        .name = "Name",
        .version_number = "VersionNumber",
    };
};
