const DataSetReference = @import("data_set_reference.zig").DataSetReference;

/// The source template of an analysis.
pub const AnalysisSourceTemplate = struct {
    /// The Amazon Resource Name (ARN) of the source template of an analysis.
    arn: []const u8,

    /// The dataset references of the source template of an analysis.
    data_set_references: []const DataSetReference,

    pub const json_field_names = .{
        .arn = "Arn",
        .data_set_references = "DataSetReferences",
    };
};
