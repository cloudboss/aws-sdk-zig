/// Information about the size of files in a merge or pull request.
pub const FileSizes = struct {
    /// The size of a file in the base of a merge or pull request.
    base: i64 = 0,

    /// The size of a file in the destination of a merge or pull request.
    destination: i64 = 0,

    /// The size of a file in the source of a merge or pull request.
    source: i64 = 0,

    pub const json_field_names = .{
        .base = "base",
        .destination = "destination",
        .source = "source",
    };
};
