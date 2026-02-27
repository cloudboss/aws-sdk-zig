pub const InferenceDataImportStrategy = enum {
    no_import,
    add_when_empty,
    overwrite,

    pub const json_field_names = .{
        .no_import = "NO_IMPORT",
        .add_when_empty = "ADD_WHEN_EMPTY",
        .overwrite = "OVERWRITE",
    };
};
