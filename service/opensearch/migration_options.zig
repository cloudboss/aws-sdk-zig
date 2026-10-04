const ExportOptions = @import("export_options.zig").ExportOptions;
const MigrationSource = @import("migration_source.zig").MigrationSource;
const MigrationWorkspace = @import("migration_workspace.zig").MigrationWorkspace;

/// The configuration options for a saved objects migration job.
pub const MigrationOptions = struct {
    /// The strategy for resolving conflicts when saved objects already exist in the
    /// target workspace. Valid values are `CREATE_NEW_COPIES`, which creates new
    /// objects with unique IDs, and `overwrite`, which replaces existing objects.
    conflict_resolution: ?[]const u8 = null,

    /// Options to filter the scope of saved objects to export from the source.
    export_options: ?ExportOptions = null,

    /// The data source from which to export saved objects.
    source: MigrationSource,

    /// The target workspace configuration for importing saved objects. You can
    /// specify an existing workspace or request creation of a new workspace.
    workspace: MigrationWorkspace,

    pub const json_field_names = .{
        .conflict_resolution = "conflictResolution",
        .export_options = "exportOptions",
        .source = "source",
        .workspace = "workspace",
    };
};
