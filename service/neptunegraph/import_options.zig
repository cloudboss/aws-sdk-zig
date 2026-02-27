const NeptuneImportOptions = @import("neptune_import_options.zig").NeptuneImportOptions;

/// Options for how to perform an import.
pub const ImportOptions = union(enum) {
    /// Options for importing data from a Neptune database.
    neptune: ?NeptuneImportOptions,

    pub const json_field_names = .{
        .neptune = "neptune",
    };
};
