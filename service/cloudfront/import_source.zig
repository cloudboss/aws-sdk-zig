const ImportSourceType = @import("import_source_type.zig").ImportSourceType;

/// The import source for the key value store.
pub const ImportSource = struct {
    /// The Amazon Resource Name (ARN) of the import source for the key value store.
    source_arn: []const u8,

    /// The source type of the import source for the key value store.
    source_type: ImportSourceType,
};
