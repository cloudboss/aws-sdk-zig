const DataSetReference = @import("data_set_reference.zig").DataSetReference;

/// The source analysis of the template.
pub const TemplateSourceAnalysis = struct {
    /// The Amazon Resource Name (ARN) of the resource.
    arn: []const u8,

    /// A structure containing information about the dataset references used as
    /// placeholders
    /// in the template.
    data_set_references: []const DataSetReference,

    pub const json_field_names = .{
        .arn = "Arn",
        .data_set_references = "DataSetReferences",
    };
};
