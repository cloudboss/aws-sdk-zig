const SAPODataPaginationConfig = @import("sapo_data_pagination_config.zig").SAPODataPaginationConfig;
const SAPODataParallelismConfig = @import("sapo_data_parallelism_config.zig").SAPODataParallelismConfig;

/// The properties that are applied when using SAPOData as a flow source.
pub const SAPODataSourceProperties = struct {
    /// The object path specified in the SAPOData flow source.
    object_path: ?[]const u8 = null,

    /// Sets the page size for each concurrent process that transfers OData records
    /// from your SAP
    /// instance.
    pagination_config: ?SAPODataPaginationConfig = null,

    /// Sets the number of concurrent processes that transfers OData records from
    /// your SAP
    /// instance.
    parallelism_config: ?SAPODataParallelismConfig = null,

    pub const json_field_names = .{
        .object_path = "objectPath",
        .pagination_config = "paginationConfig",
        .parallelism_config = "parallelismConfig",
    };
};
