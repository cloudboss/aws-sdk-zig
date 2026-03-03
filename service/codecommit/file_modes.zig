const FileModeTypeEnum = @import("file_mode_type_enum.zig").FileModeTypeEnum;

/// Information about file modes in a merge or pull request.
pub const FileModes = struct {
    /// The file mode of a file in the base of a merge or pull request.
    base: ?FileModeTypeEnum = null,

    /// The file mode of a file in the destination of a merge or pull request.
    destination: ?FileModeTypeEnum = null,

    /// The file mode of a file in the source of a merge or pull request.
    source: ?FileModeTypeEnum = null,

    pub const json_field_names = .{
        .base = "base",
        .destination = "destination",
        .source = "source",
    };
};
