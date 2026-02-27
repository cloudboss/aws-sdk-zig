const aws = @import("aws");

const PrincipalPermissions = @import("principal_permissions.zig").PrincipalPermissions;
const FederatedDatabase = @import("federated_database.zig").FederatedDatabase;
const DatabaseIdentifier = @import("database_identifier.zig").DatabaseIdentifier;

/// The structure used to create or update a database.
pub const DatabaseInput = struct {
    /// Creates a set of default permissions on the table for principals. Used by
    /// Lake Formation. Not used in the normal course of Glue operations.
    create_table_default_permissions: ?[]const PrincipalPermissions,

    /// A description of the database.
    description: ?[]const u8,

    /// A `FederatedDatabase` structure that references an entity outside the Glue
    /// Data Catalog.
    federated_database: ?FederatedDatabase,

    /// The location of the database (for example, an HDFS path).
    location_uri: ?[]const u8,

    /// The name of the database. For Hive compatibility, this is folded to
    /// lowercase when it is
    /// stored.
    name: []const u8,

    /// These key-value pairs define parameters and properties
    /// of the database.
    ///
    /// These key-value pairs define parameters and properties of the database.
    parameters: ?[]const aws.map.StringMapEntry,

    /// A `DatabaseIdentifier` structure that describes a target database for
    /// resource linking.
    target_database: ?DatabaseIdentifier,

    pub const json_field_names = .{
        .create_table_default_permissions = "CreateTableDefaultPermissions",
        .description = "Description",
        .federated_database = "FederatedDatabase",
        .location_uri = "LocationUri",
        .name = "Name",
        .parameters = "Parameters",
        .target_database = "TargetDatabase",
    };
};
