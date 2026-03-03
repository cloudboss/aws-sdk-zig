const aws = @import("aws");

const DataLakeAccessProperties = @import("data_lake_access_properties.zig").DataLakeAccessProperties;
const IcebergOptimizationProperties = @import("iceberg_optimization_properties.zig").IcebergOptimizationProperties;

/// A structure that specifies data lake access properties and other custom
/// properties.
pub const CatalogProperties = struct {
    /// Additional key-value properties for the catalog, such as column statistics
    /// optimizations.
    custom_properties: ?[]const aws.map.StringMapEntry = null,

    /// A `DataLakeAccessProperties` object that specifies properties to configure
    /// data lake access for your catalog resource in the Glue Data Catalog.
    data_lake_access_properties: ?DataLakeAccessProperties = null,

    /// A structure that specifies Iceberg table optimization properties for the
    /// catalog. This includes configuration for compaction, retention, and
    /// orphan file deletion operations that can be applied to Iceberg tables in
    /// this catalog.
    iceberg_optimization_properties: ?IcebergOptimizationProperties = null,

    pub const json_field_names = .{
        .custom_properties = "CustomProperties",
        .data_lake_access_properties = "DataLakeAccessProperties",
        .iceberg_optimization_properties = "IcebergOptimizationProperties",
    };
};
