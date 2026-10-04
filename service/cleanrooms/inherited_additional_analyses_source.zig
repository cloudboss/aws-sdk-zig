const BaseTableDependencyType = @import("base_table_dependency_type.zig").BaseTableDependencyType;
const AdditionalAnalyses = @import("additional_analyses.zig").AdditionalAnalyses;

/// Contains information about a parent table that contributes an additional
/// analyses constraint.
pub const InheritedAdditionalAnalysesSource = struct {
    /// The unique identifier of the parent table.
    id: []const u8,

    /// The name of the parent table.
    name: []const u8,

    /// The Amazon Web Services account ID of the member who owns the parent table.
    source_account_id: []const u8,

    /// The type of the parent table.
    @"type": BaseTableDependencyType,

    /// The additional analyses setting defined on the parent table.
    value: AdditionalAnalyses,

    pub const json_field_names = .{
        .id = "id",
        .name = "name",
        .source_account_id = "sourceAccountId",
        .@"type" = "type",
        .value = "value",
    };
};
