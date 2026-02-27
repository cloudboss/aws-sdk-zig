/// The usage configuration to apply to child datasets that reference this
/// dataset as a source.
pub const DataSetUsageConfiguration = struct {
    /// An option that controls whether a child dataset of a direct query can use
    /// this dataset as a source.
    disable_use_as_direct_query_source: bool = false,

    /// An option that controls whether a child dataset that's stored in Quick Sight
    /// can use this dataset as a source.
    disable_use_as_imported_source: bool = false,

    pub const json_field_names = .{
        .disable_use_as_direct_query_source = "DisableUseAsDirectQuerySource",
        .disable_use_as_imported_source = "DisableUseAsImportedSource",
    };
};
