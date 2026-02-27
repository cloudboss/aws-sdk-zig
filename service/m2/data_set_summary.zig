/// A subset of the possible data set attributes.
pub const DataSetSummary = struct {
    /// The timestamp when the data set was created.
    creation_time: ?i64,

    /// The name of the data set.
    data_set_name: []const u8,

    /// The type of data set. The only supported value is VSAM.
    data_set_org: ?[]const u8,

    /// The format of the data set.
    format: ?[]const u8,

    /// The last time the data set was referenced.
    last_referenced_time: ?i64,

    /// The last time the data set was updated.
    last_updated_time: ?i64,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .data_set_name = "dataSetName",
        .data_set_org = "dataSetOrg",
        .format = "format",
        .last_referenced_time = "lastReferencedTime",
        .last_updated_time = "lastUpdatedTime",
    };
};
