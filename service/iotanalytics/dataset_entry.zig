/// The reference to a dataset entry.
pub const DatasetEntry = struct {
    /// The presigned URI of the dataset item.
    data_uri: ?[]const u8,

    /// The name of the dataset item.
    entry_name: ?[]const u8,

    pub const json_field_names = .{
        .data_uri = "dataURI",
        .entry_name = "entryName",
    };
};
