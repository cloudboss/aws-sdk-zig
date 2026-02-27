const FilterStatus = @import("filter_status.zig").FilterStatus;

/// The summary of the asset filter.
pub const AssetFilterSummary = struct {
    /// The ID of the data asset.
    asset_id: []const u8,

    /// The timestamp at which the asset filter was created.
    created_at: ?i64,

    /// The description of the asset filter.
    description: ?[]const u8,

    /// The ID of the domain where the asset filter lives.
    domain_id: []const u8,

    /// The effective column names of the asset filter.
    effective_column_names: ?[]const []const u8,

    /// The effective row filter of the asset filter.
    effective_row_filter: ?[]const u8,

    /// The error message that is displayed if the action does not succeed.
    error_message: ?[]const u8,

    /// The ID of the asset filter.
    id: []const u8,

    /// The name of the asset filter.
    name: []const u8,

    /// The status of the asset filter.
    status: ?FilterStatus,

    pub const json_field_names = .{
        .asset_id = "assetId",
        .created_at = "createdAt",
        .description = "description",
        .domain_id = "domainId",
        .effective_column_names = "effectiveColumnNames",
        .effective_row_filter = "effectiveRowFilter",
        .error_message = "errorMessage",
        .id = "id",
        .name = "name",
        .status = "status",
    };
};
