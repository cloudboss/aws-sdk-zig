const Heterogeneous = @import("heterogeneous.zig").Heterogeneous;
const Homogeneous = @import("homogeneous.zig").Homogeneous;
const NoDatabaseMigrationPreference = @import("no_database_migration_preference.zig").NoDatabaseMigrationPreference;

/// Preferences for migrating a database to AWS.
pub const DatabaseMigrationPreference = union(enum) {
    /// Indicates whether you are interested in moving from one type of database to
    /// another. For
    /// example, from SQL Server to Amazon Aurora MySQL-Compatible Edition.
    heterogeneous: ?Heterogeneous,
    /// Indicates whether you are interested in moving to the same type of database
    /// into AWS.
    /// For example, from SQL Server in your environment to SQL Server on AWS.
    homogeneous: ?Homogeneous,
    /// Indicated that you do not prefer heterogeneous or homogeneous.
    no_preference: ?NoDatabaseMigrationPreference,

    pub const json_field_names = .{
        .heterogeneous = "heterogeneous",
        .homogeneous = "homogeneous",
        .no_preference = "noPreference",
    };
};
