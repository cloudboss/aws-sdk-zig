/// Contains the name and identifier of a pipeline.
pub const PipelineIdName = struct {
    /// The ID of the pipeline that was assigned by AWS Data Pipeline. This is a
    /// string of the form `df-297EG78HU43EEXAMPLE`.
    id: ?[]const u8,

    /// The name of the pipeline.
    name: ?[]const u8,

    pub const json_field_names = .{
        .id = "id",
        .name = "name",
    };
};
