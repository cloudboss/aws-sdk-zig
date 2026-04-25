/// Filters for listing network migration analysis results.
pub const ListNetworkMigrationAnalysisResultsFilters = struct {
    /// A list of VPC IDs to filter results by.
    vpc_i_ds: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .vpc_i_ds = "vpcIDs",
    };
};
