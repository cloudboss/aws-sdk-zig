const DbWorkload = @import("db_workload.zig").DbWorkload;

/// A summary of an available Oracle Database software version for Autonomous
/// Databases.
pub const AutonomousDatabaseVersionSummary = struct {
    /// The intended use of the Autonomous Database that the version supports, such
    /// as transaction processing, data warehouse, JSON database, or APEX.
    db_workload: ?DbWorkload = null,

    /// Additional details about the Autonomous Database software version.
    details: ?[]const u8 = null,

    /// The Oracle Database software version.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .db_workload = "dbWorkload",
        .details = "details",
        .version = "version",
    };
};
