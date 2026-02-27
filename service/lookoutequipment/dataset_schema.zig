/// Provides information about the data schema used with the given dataset.
pub const DatasetSchema = struct {
    /// The data schema used within the given dataset.
    inline_data_schema: ?[]const u8,

    pub const json_field_names = .{
        .inline_data_schema = "InlineDataSchema",
    };
};
