const aws = @import("aws");

const DataLakeAccessPropertiesOutput = @import("data_lake_access_properties_output.zig").DataLakeAccessPropertiesOutput;
const IcebergOptimizationPropertiesOutput = @import("iceberg_optimization_properties_output.zig").IcebergOptimizationPropertiesOutput;

/// Property attributes that include configuration properties for the catalog
/// resource.
pub const CatalogPropertiesOutput = struct {
    /// Additional key-value properties for the catalog, such as column statistics
    /// optimizations.
    custom_properties: ?[]const aws.map.StringMapEntry = null,

    /// A `DataLakeAccessProperties` object with input properties to configure data
    /// lake access for your catalog resource in the Glue Data Catalog.
    data_lake_access_properties: ?DataLakeAccessPropertiesOutput = null,

    /// An `IcebergOptimizationPropertiesOutput` object that specifies Iceberg table
    /// optimization settings for the catalog, including
    /// configurations for compaction, retention, and orphan file deletion
    /// operations.
    iceberg_optimization_properties: ?IcebergOptimizationPropertiesOutput = null,

    pub const json_field_names = .{
        .custom_properties = "CustomProperties",
        .data_lake_access_properties = "DataLakeAccessProperties",
        .iceberg_optimization_properties = "IcebergOptimizationProperties",
    };
};
