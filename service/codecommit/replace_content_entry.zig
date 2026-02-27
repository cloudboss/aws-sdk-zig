const FileModeTypeEnum = @import("file_mode_type_enum.zig").FileModeTypeEnum;
const ReplacementTypeEnum = @import("replacement_type_enum.zig").ReplacementTypeEnum;

/// Information about a replacement content entry in the conflict of a merge or
/// pull request operation.
pub const ReplaceContentEntry = struct {
    /// The base-64 encoded content to use when the replacement type is
    /// USE_NEW_CONTENT.
    content: ?[]const u8,

    /// The file mode to apply during conflict resoltion.
    file_mode: ?FileModeTypeEnum,

    /// The path of the conflicting file.
    file_path: []const u8,

    /// The replacement type to use when determining how to resolve the conflict.
    replacement_type: ReplacementTypeEnum,

    pub const json_field_names = .{
        .content = "content",
        .file_mode = "fileMode",
        .file_path = "filePath",
        .replacement_type = "replacementType",
    };
};
