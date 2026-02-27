const aws = @import("aws");

const AllowFullTableExternalDataAccessEnum = @import("allow_full_table_external_data_access_enum.zig").AllowFullTableExternalDataAccessEnum;
const CatalogProperties = @import("catalog_properties.zig").CatalogProperties;
const PrincipalPermissions = @import("principal_permissions.zig").PrincipalPermissions;
const FederatedCatalog = @import("federated_catalog.zig").FederatedCatalog;
const TargetRedshiftCatalog = @import("target_redshift_catalog.zig").TargetRedshiftCatalog;

/// A structure that describes catalog properties.
pub const CatalogInput = struct {
    /// Allows third-party engines to access data in Amazon S3 locations that are
    /// registered with Lake Formation.
    allow_full_table_external_data_access: ?AllowFullTableExternalDataAccessEnum,

    /// A `CatalogProperties` object that specifies data lake access properties and
    /// other custom properties.
    catalog_properties: ?CatalogProperties,

    /// An array of `PrincipalPermissions` objects. Creates a set of default
    /// permissions on the database(s) for principals. Used by Amazon Web Services
    /// Lake Formation. Typically should be explicitly set as an empty list.
    create_database_default_permissions: ?[]const PrincipalPermissions,

    /// An array of `PrincipalPermissions` objects. Creates a set of default
    /// permissions on the table(s) for principals. Used by Amazon Web Services Lake
    /// Formation. Typically should be explicitly set as an empty list.
    create_table_default_permissions: ?[]const PrincipalPermissions,

    /// Description string, not more than 2048 bytes long, matching the URI address
    /// multi-line string pattern. A description of the catalog.
    description: ?[]const u8,

    /// A `FederatedCatalog` object. A `FederatedCatalog` structure that references
    /// an entity outside the Glue Data Catalog, for example a Redshift database.
    federated_catalog: ?FederatedCatalog,

    /// A map array of key-value pairs that define the parameters and properties of
    /// the catalog.
    parameters: ?[]const aws.map.StringMapEntry,

    /// A `TargetRedshiftCatalog` object that describes a target catalog for
    /// resource linking.
    target_redshift_catalog: ?TargetRedshiftCatalog,

    pub const json_field_names = .{
        .allow_full_table_external_data_access = "AllowFullTableExternalDataAccess",
        .catalog_properties = "CatalogProperties",
        .create_database_default_permissions = "CreateDatabaseDefaultPermissions",
        .create_table_default_permissions = "CreateTableDefaultPermissions",
        .description = "Description",
        .federated_catalog = "FederatedCatalog",
        .parameters = "Parameters",
        .target_redshift_catalog = "TargetRedshiftCatalog",
    };
};
