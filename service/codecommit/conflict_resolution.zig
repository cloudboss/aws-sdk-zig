const DeleteFileEntry = @import("delete_file_entry.zig").DeleteFileEntry;
const ReplaceContentEntry = @import("replace_content_entry.zig").ReplaceContentEntry;
const SetFileModeEntry = @import("set_file_mode_entry.zig").SetFileModeEntry;

/// If AUTOMERGE is the conflict resolution strategy, a list of inputs to use
/// when
/// resolving conflicts during a merge.
pub const ConflictResolution = struct {
    /// Files to be deleted as part of the merge conflict resolution.
    delete_files: ?[]const DeleteFileEntry,

    /// Files to have content replaced as part of the merge conflict resolution.
    replace_contents: ?[]const ReplaceContentEntry,

    /// File modes that are set as part of the merge conflict resolution.
    set_file_modes: ?[]const SetFileModeEntry,

    pub const json_field_names = .{
        .delete_files = "deleteFiles",
        .replace_contents = "replaceContents",
        .set_file_modes = "setFileModes",
    };
};
