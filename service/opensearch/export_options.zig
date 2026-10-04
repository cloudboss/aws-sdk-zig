const SavedObjectIdentifier = @import("saved_object_identifier.zig").SavedObjectIdentifier;

/// Options to filter the scope of saved objects to export during a migration.
pub const ExportOptions = struct {
    /// Specifies whether to include all objects referenced by the exported objects,
    /// recursively.
    include_references_deep: ?bool = null,

    /// A list of specific saved objects to include in the migration, identified by
    /// type and ID.
    objects: ?[]const SavedObjectIdentifier = null,

    /// A list of saved object types to include in the migration. Valid values
    /// include `dashboard`, `visualization`, `index-pattern`, `search`, and
    /// `query`.
    types: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .include_references_deep = "includeReferencesDeep",
        .objects = "objects",
        .types = "types",
    };
};
