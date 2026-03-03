/// Properties used by the source leg to process data from the source.
pub const SourceTableConfig = struct {
    /// A list of fields used for column-level filtering. Currently unsupported.
    fields: ?[]const []const u8 = null,

    /// A condition clause used for row-level filtering. Currently unsupported.
    filter_predicate: ?[]const u8 = null,

    /// Provide the primary key set for this table. Currently supported specifically
    /// for SAP `EntityOf` entities upon request. Contact
    /// Amazon Web Services Support to make this feature available.
    primary_key: ?[]const []const u8 = null,

    /// Incremental pull timestamp-based field. Currently unsupported.
    record_update_field: ?[]const u8 = null,

    pub const json_field_names = .{
        .fields = "Fields",
        .filter_predicate = "FilterPredicate",
        .primary_key = "PrimaryKey",
        .record_update_field = "RecordUpdateField",
    };
};
