const DataSetReference = @import("data_set_reference.zig").DataSetReference;
const TopicReference = @import("topic_reference.zig").TopicReference;

/// The source analysis of the template.
pub const TemplateSourceAnalysis = struct {
    /// The Amazon Resource Name (ARN) of the resource.
    arn: []const u8,

    /// A structure containing information about the dataset references used as
    /// placeholders
    /// in the template.
    data_set_references: []const DataSetReference,

    /// A structure containing information about the topic references used as
    /// placeholders
    /// in the template.
    topic_references: ?[]const TopicReference = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .data_set_references = "DataSetReferences",
        .topic_references = "TopicReferences",
    };
};
