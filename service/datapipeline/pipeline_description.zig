const Field = @import("field.zig").Field;
const Tag = @import("tag.zig").Tag;

/// Contains pipeline metadata.
pub const PipelineDescription = struct {
    /// Description of the pipeline.
    description: ?[]const u8,

    /// A list of read-only fields that contain metadata about the pipeline:
    /// @userId, @accountId, and @pipelineState.
    fields: []const Field,

    /// The name of the pipeline.
    name: []const u8,

    /// The pipeline identifier that was assigned by AWS Data Pipeline. This is a
    /// string of the form `df-297EG78HU43EEXAMPLE`.
    pipeline_id: []const u8,

    /// A list of tags to associated with a pipeline. Tags let you control access to
    /// pipelines.
    /// For more information, see [Controlling User Access to
    /// Pipelines](http://docs.aws.amazon.com/datapipeline/latest/DeveloperGuide/dp-control-access.html) in the *AWS Data Pipeline Developer Guide*.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .description = "description",
        .fields = "fields",
        .name = "name",
        .pipeline_id = "pipelineId",
        .tags = "tags",
    };
};
