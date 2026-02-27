const aws = @import("aws");

const FormEntryOutput = @import("form_entry_output.zig").FormEntryOutput;

/// The details of a data lineage node type.
pub const LineageNodeTypeItem = struct {
    /// The timestamp at which the data lineage node type was created.
    created_at: ?i64,

    /// The user who created the data lineage node type.
    created_by: ?[]const u8,

    /// The description of the data lineage node type.
    description: ?[]const u8,

    /// The ID of the domain where the data lineage node type lives.
    domain_id: []const u8,

    /// The forms output of the data lineage node type.
    forms_output: []const aws.map.MapEntry(FormEntryOutput),

    /// The name of the data lineage node type.
    name: ?[]const u8,

    /// The revision of the data lineage node type.
    revision: []const u8,

    /// The timestamp at which the data lineage node type was updated.
    updated_at: ?i64,

    /// The user who updated the data lineage node type.
    updated_by: ?[]const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .description = "description",
        .domain_id = "domainId",
        .forms_output = "formsOutput",
        .name = "name",
        .revision = "revision",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
    };
};
