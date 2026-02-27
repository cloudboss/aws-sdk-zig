const DataSetReference = @import("data_set_reference.zig").DataSetReference;

/// Dashboard source template.
pub const DashboardSourceTemplate = struct {
    /// The Amazon Resource Name (ARN) of the resource.
    arn: []const u8,

    /// Dataset references.
    data_set_references: []const DataSetReference,

    pub const json_field_names = .{
        .arn = "Arn",
        .data_set_references = "DataSetReferences",
    };
};
