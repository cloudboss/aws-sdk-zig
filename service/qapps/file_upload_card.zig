const CardType = @import("card_type.zig").CardType;

/// A card in an Amazon Q App that allows the user to upload a file.
pub const FileUploadCard = struct {
    /// A flag indicating if the user can override the default file for the upload
    /// card.
    allow_override: ?bool,

    /// Any dependencies or requirements for the file upload card.
    dependencies: []const []const u8,

    /// The unique identifier of the file associated with the card.
    file_id: ?[]const u8,

    /// The name of the file being uploaded.
    filename: ?[]const u8,

    /// The unique identifier of the file upload card.
    id: []const u8,

    /// The title of the file upload card.
    title: []const u8,

    /// The type of the card.
    @"type": CardType,

    pub const json_field_names = .{
        .allow_override = "allowOverride",
        .dependencies = "dependencies",
        .file_id = "fileId",
        .filename = "filename",
        .id = "id",
        .title = "title",
        .@"type" = "type",
    };
};
