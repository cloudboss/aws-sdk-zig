const aws = @import("aws");

/// Provides a summary of an experiment template.
pub const ExperimentTemplateSummary = struct {
    /// The Amazon Resource Name (ARN) of the experiment template.
    arn: ?[]const u8 = null,

    /// The time that the experiment template was created.
    creation_time: ?i64 = null,

    /// The description of the experiment template.
    description: ?[]const u8 = null,

    /// The ID of the experiment template.
    id: ?[]const u8 = null,

    /// The time that the experiment template was last updated.
    last_update_time: ?i64 = null,

    /// The tags for the experiment template.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_time = "creationTime",
        .description = "description",
        .id = "id",
        .last_update_time = "lastUpdateTime",
        .tags = "tags",
    };
};
