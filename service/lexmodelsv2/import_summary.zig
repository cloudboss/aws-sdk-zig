const ImportResourceType = @import("import_resource_type.zig").ImportResourceType;
const ImportStatus = @import("import_status.zig").ImportStatus;
const MergeStrategy = @import("merge_strategy.zig").MergeStrategy;

/// Provides summary information about an import in an import
/// list.
pub const ImportSummary = struct {
    /// The date and time that the import was created.
    creation_date_time: ?i64 = null,

    /// The unique identifier that Amazon Lex assigned to the imported
    /// resource.
    imported_resource_id: ?[]const u8 = null,

    /// The name that you gave the imported resource.
    imported_resource_name: ?[]const u8 = null,

    /// The type of resource that was imported.
    imported_resource_type: ?ImportResourceType = null,

    /// The unique identifier that Amazon Lex assigned to the import.
    import_id: ?[]const u8 = null,

    /// The status of the resource. When the status is
    /// `Completed` the resource is ready to build.
    import_status: ?ImportStatus = null,

    /// The date and time that the import was last updated.
    last_updated_date_time: ?i64 = null,

    /// The strategy used to merge existing bot or bot locale definitions
    /// with the imported definition.
    merge_strategy: ?MergeStrategy = null,

    pub const json_field_names = .{
        .creation_date_time = "creationDateTime",
        .imported_resource_id = "importedResourceId",
        .imported_resource_name = "importedResourceName",
        .imported_resource_type = "importedResourceType",
        .import_id = "importId",
        .import_status = "importStatus",
        .last_updated_date_time = "lastUpdatedDateTime",
        .merge_strategy = "mergeStrategy",
    };
};
