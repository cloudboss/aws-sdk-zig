const FileModes = @import("file_modes.zig").FileModes;
const FileSizes = @import("file_sizes.zig").FileSizes;
const IsBinaryFile = @import("is_binary_file.zig").IsBinaryFile;
const MergeOperations = @import("merge_operations.zig").MergeOperations;
const ObjectTypes = @import("object_types.zig").ObjectTypes;

/// Information about the metadata for a conflict in a merge operation.
pub const ConflictMetadata = struct {
    /// A boolean value indicating whether there are conflicts in the content of a
    /// file.
    content_conflict: bool = false,

    /// A boolean value indicating whether there are conflicts in the file mode of a
    /// file.
    file_mode_conflict: bool = false,

    /// The file modes of the file in the source, destination, and base of the
    /// merge.
    file_modes: ?FileModes = null,

    /// The path of the file that contains conflicts.
    file_path: ?[]const u8 = null,

    /// The file sizes of the file in the source, destination, and base of the
    /// merge.
    file_sizes: ?FileSizes = null,

    /// A boolean value (true or false) indicating whether the file is binary or
    /// textual in the source, destination, and base of the merge.
    is_binary_file: ?IsBinaryFile = null,

    /// Whether an add, modify, or delete operation caused the conflict between the
    /// source and destination of the merge.
    merge_operations: ?MergeOperations = null,

    /// The number of conflicts, including both hunk conflicts and metadata
    /// conflicts.
    number_of_conflicts: i32 = 0,

    /// A boolean value (true or false) indicating whether there are conflicts
    /// between the branches in the object type of a file, folder, or submodule.
    object_type_conflict: bool = false,

    /// Information about any object type conflicts in a merge operation.
    object_types: ?ObjectTypes = null,

    pub const json_field_names = .{
        .content_conflict = "contentConflict",
        .file_mode_conflict = "fileModeConflict",
        .file_modes = "fileModes",
        .file_path = "filePath",
        .file_sizes = "fileSizes",
        .is_binary_file = "isBinaryFile",
        .merge_operations = "mergeOperations",
        .number_of_conflicts = "numberOfConflicts",
        .object_type_conflict = "objectTypeConflict",
        .object_types = "objectTypes",
    };
};
