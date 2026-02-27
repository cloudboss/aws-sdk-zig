const aws = @import("aws");

const SemanticTable = @import("semantic_table.zig").SemanticTable;

/// Configuration for the semantic model that defines how prepared data is
/// structured for analysis and reporting.
pub const SemanticModelConfiguration = struct {
    /// A map of semantic tables that define the analytical structure.
    table_map: ?[]const aws.map.MapEntry(SemanticTable),

    pub const json_field_names = .{
        .table_map = "TableMap",
    };
};
