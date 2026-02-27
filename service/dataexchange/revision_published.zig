/// Information about the published revision.
pub const RevisionPublished = struct {
    /// The data set ID of the published revision.
    data_set_id: []const u8,

    pub const json_field_names = .{
        .data_set_id = "DataSetId",
    };
};
