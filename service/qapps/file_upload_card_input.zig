const CardType = @import("card_type.zig").CardType;

/// Represents a file upload card. It can optionally receive a `filename` and
/// `fileId` to set a default file. If not received, the user must provide the
/// file when the Q App runs.
pub const FileUploadCardInput = struct {
    /// A flag indicating if the user can override the default file for the upload
    /// card.
    allow_override: ?bool,

    /// The identifier of a pre-uploaded file associated with the card.
    file_id: ?[]const u8,

    /// The default filename to use for the file upload card.
    filename: ?[]const u8,

    /// The unique identifier of the file upload card.
    id: []const u8,

    /// The title or label of the file upload card.
    title: []const u8,

    /// The type of the card.
    type: CardType = "file-upload",

    pub const json_field_names = .{
        .allow_override = "allowOverride",
        .file_id = "fileId",
        .filename = "filename",
        .id = "id",
        .title = "title",
        .type = "type",
    };
};
