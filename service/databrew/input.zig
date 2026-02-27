const DatabaseInputDefinition = @import("database_input_definition.zig").DatabaseInputDefinition;
const DataCatalogInputDefinition = @import("data_catalog_input_definition.zig").DataCatalogInputDefinition;
const Metadata = @import("metadata.zig").Metadata;
const S3Location = @import("s3_location.zig").S3Location;

/// Represents information on how DataBrew can find data, in either the Glue
/// Data Catalog or
/// Amazon S3.
pub const Input = struct {
    /// Connection information for dataset input files stored in a database.
    database_input_definition: ?DatabaseInputDefinition,

    /// The Glue Data Catalog parameters for the data.
    data_catalog_input_definition: ?DataCatalogInputDefinition,

    /// Contains additional resource information needed for specific datasets.
    metadata: ?Metadata,

    /// The Amazon S3 location where the data is stored.
    s3_input_definition: ?S3Location,

    pub const json_field_names = .{
        .database_input_definition = "DatabaseInputDefinition",
        .data_catalog_input_definition = "DataCatalogInputDefinition",
        .metadata = "Metadata",
        .s3_input_definition = "S3InputDefinition",
    };
};
