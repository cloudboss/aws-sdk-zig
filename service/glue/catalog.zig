const aws = @import("aws");

const AllowFullTableExternalDataAccessEnum = @import("allow_full_table_external_data_access_enum.zig").AllowFullTableExternalDataAccessEnum;
const CatalogPropertiesOutput = @import("catalog_properties_output.zig").CatalogPropertiesOutput;
const PrincipalPermissions = @import("principal_permissions.zig").PrincipalPermissions;
const FederatedCatalog = @import("federated_catalog.zig").FederatedCatalog;
const TargetRedshiftCatalog = @import("target_redshift_catalog.zig").TargetRedshiftCatalog;

/// The catalog object represents a logical grouping of databases in the Glue
/// Data Catalog or a federated source. You can now create a Redshift-federated
/// catalog or a catalog containing resource links to Redshift databases in
/// another account or region.
pub const Catalog = struct {
    /// Allows third-party engines to access data in Amazon S3 locations that are
    /// registered with Lake Formation.
    allow_full_table_external_data_access: ?AllowFullTableExternalDataAccessEnum = null,

    /// The ID of the catalog. To grant access to the default catalog, this field
    /// should not be provided.
    catalog_id: ?[]const u8 = null,

    /// A `CatalogProperties` object that specifies data lake access properties and
    /// other custom properties.
    catalog_properties: ?CatalogPropertiesOutput = null,

    /// An array of `PrincipalPermissions` objects. Creates a set of default
    /// permissions on the database(s) for principals. Used by Amazon Web Services
    /// Lake Formation. Not used in the normal course of Glue operations.
    create_database_default_permissions: ?[]const PrincipalPermissions = null,

    /// An array of `PrincipalPermissions` objects. Creates a set of default
    /// permissions on the table(s) for principals. Used by Amazon Web Services Lake
    /// Formation. Not used in the normal course of Glue operations.
    create_table_default_permissions: ?[]const PrincipalPermissions = null,

    /// The time at which the catalog was created.
    create_time: ?i64 = null,

    /// Description string, not more than 2048 bytes long, matching the URI address
    /// multi-line string pattern. A description of the catalog.
    description: ?[]const u8 = null,

    /// A `FederatedCatalog` object that points to an entity outside the Glue Data
    /// Catalog.
    federated_catalog: ?FederatedCatalog = null,

    /// The name of the catalog. Cannot be the same as the account ID.
    name: []const u8,

    /// A map array of key-value pairs that define parameters and properties of the
    /// catalog.
    parameters: ?[]const aws.map.StringMapEntry = null,

    /// The Amazon Resource Name (ARN) assigned to the catalog resource.
    resource_arn: ?[]const u8 = null,

    /// A `TargetRedshiftCatalog` object that describes a target catalog for
    /// database resource linking.
    target_redshift_catalog: ?TargetRedshiftCatalog = null,

    /// The time at which the catalog was last updated.
    update_time: ?i64 = null,

    pub const json_field_names = .{
        .allow_full_table_external_data_access = "AllowFullTableExternalDataAccess",
        .catalog_id = "CatalogId",
        .catalog_properties = "CatalogProperties",
        .create_database_default_permissions = "CreateDatabaseDefaultPermissions",
        .create_table_default_permissions = "CreateTableDefaultPermissions",
        .create_time = "CreateTime",
        .description = "Description",
        .federated_catalog = "FederatedCatalog",
        .name = "Name",
        .parameters = "Parameters",
        .resource_arn = "ResourceArn",
        .target_redshift_catalog = "TargetRedshiftCatalog",
        .update_time = "UpdateTime",
    };
};
