const aws = @import("aws");

const DatabaseConnectionStringProfile = @import("database_connection_string_profile.zig").DatabaseConnectionStringProfile;

/// The connection strings used to connect to an Autonomous Database.
pub const AutonomousDatabaseConnectionStrings = struct {
    /// The list of all connection strings that you can use to connect to the
    /// Autonomous Database.
    all_connection_strings: ?[]const aws.map.StringMapEntry = null,

    /// The connection string for connecting to the Autonomous Database with a
    /// dedicated service.
    dedicated: ?[]const u8 = null,

    /// The connection string for the high-priority database service.
    high: ?[]const u8 = null,

    /// The connection string for the low-priority database service.
    low: ?[]const u8 = null,

    /// The connection string for the medium-priority database service.
    medium: ?[]const u8 = null,

    /// The list of connection string profiles for the Autonomous Database.
    profiles: ?[]const DatabaseConnectionStringProfile = null,

    pub const json_field_names = .{
        .all_connection_strings = "allConnectionStrings",
        .dedicated = "dedicated",
        .high = "high",
        .low = "low",
        .medium = "medium",
        .profiles = "profiles",
    };
};
