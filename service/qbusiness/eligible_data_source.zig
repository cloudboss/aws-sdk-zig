/// The identifier of the data source Amazon Q Business will generate responses
/// from.
pub const EligibleDataSource = struct {
    /// The identifier of the data source.
    data_source_id: ?[]const u8,

    /// The identifier of the index the data source is attached to.
    index_id: ?[]const u8,

    pub const json_field_names = .{
        .data_source_id = "dataSourceId",
        .index_id = "indexId",
    };
};
