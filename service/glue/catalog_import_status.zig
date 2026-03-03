/// A structure containing migration status information.
pub const CatalogImportStatus = struct {
    /// `True` if the migration has completed, or `False` otherwise.
    import_completed: bool = false,

    /// The name of the person who initiated the migration.
    imported_by: ?[]const u8 = null,

    /// The time that the migration was started.
    import_time: ?i64 = null,

    pub const json_field_names = .{
        .import_completed = "ImportCompleted",
        .imported_by = "ImportedBy",
        .import_time = "ImportTime",
    };
};
