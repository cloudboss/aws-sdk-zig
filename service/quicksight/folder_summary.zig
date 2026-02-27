const FolderType = @import("folder_type.zig").FolderType;
const SharingModel = @import("sharing_model.zig").SharingModel;

/// A summary of information about an existing Quick Sight folder.
pub const FolderSummary = struct {
    /// The Amazon Resource Name (ARN) of the folder.
    arn: ?[]const u8,

    /// The time that the folder was created.
    created_time: ?i64,

    /// The ID of the folder.
    folder_id: ?[]const u8,

    /// The type of folder.
    folder_type: ?FolderType,

    /// The time that the folder was last updated.
    last_updated_time: ?i64,

    /// The display name of the folder.
    name: ?[]const u8,

    /// The sharing scope of the folder.
    sharing_model: ?SharingModel,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_time = "CreatedTime",
        .folder_id = "FolderId",
        .folder_type = "FolderType",
        .last_updated_time = "LastUpdatedTime",
        .name = "Name",
        .sharing_model = "SharingModel",
    };
};
