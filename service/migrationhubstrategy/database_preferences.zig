const DatabaseManagementPreference = @import("database_management_preference.zig").DatabaseManagementPreference;
const DatabaseMigrationPreference = @import("database_migration_preference.zig").DatabaseMigrationPreference;

/// Preferences on managing your databases on AWS.
pub const DatabasePreferences = struct {
    /// Specifies whether you're interested in self-managed databases or databases
    /// managed by
    /// AWS.
    database_management_preference: ?DatabaseManagementPreference = null,

    /// Specifies your preferred migration path.
    database_migration_preference: ?DatabaseMigrationPreference = null,

    pub const json_field_names = .{
        .database_management_preference = "databaseManagementPreference",
        .database_migration_preference = "databaseMigrationPreference",
    };
};
