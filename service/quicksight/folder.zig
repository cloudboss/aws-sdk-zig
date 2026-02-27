const FolderType = @import("folder_type.zig").FolderType;
const SharingModel = @import("sharing_model.zig").SharingModel;

/// A folder in Quick Sight.
pub const Folder = struct {
    /// The Amazon Resource Name (ARN) for the folder.
    arn: ?[]const u8,

    /// The time that the folder was created.
    created_time: ?i64,

    /// The ID of the folder.
    folder_id: ?[]const u8,

    /// An array of ancestor ARN strings for the folder.
    folder_path: ?[]const []const u8,

    /// The type of folder it is.
    folder_type: ?FolderType,

    /// The time that the folder was last updated.
    last_updated_time: ?i64,

    /// A display name for the folder.
    name: ?[]const u8,

    /// The sharing scope of the folder.
    sharing_model: ?SharingModel,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_time = "CreatedTime",
        .folder_id = "FolderId",
        .folder_path = "FolderPath",
        .folder_type = "FolderType",
        .last_updated_time = "LastUpdatedTime",
        .name = "Name",
        .sharing_model = "SharingModel",
    };
};
