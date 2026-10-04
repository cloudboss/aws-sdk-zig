const DataSetReference = @import("data_set_reference.zig").DataSetReference;
const TopicReference = @import("topic_reference.zig").TopicReference;

/// Dashboard source template.
pub const DashboardSourceTemplate = struct {
    /// The Amazon Resource Name (ARN) of the resource.
    arn: []const u8,

    /// Dataset references.
    data_set_references: []const DataSetReference,

    /// The topic references for the source template of a dashboard.
    topic_references: ?[]const TopicReference = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .data_set_references = "DataSetReferences",
        .topic_references = "TopicReferences",
    };
};
