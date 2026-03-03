const ApplicationCredential = @import("application_credential.zig").ApplicationCredential;
const DatabaseType = @import("database_type.zig").DatabaseType;
const DatabaseStatus = @import("database_status.zig").DatabaseStatus;

/// The SAP HANA database of the application registered with AWS Systems Manager
/// for SAP.
pub const Database = struct {
    /// The ID of the application.
    application_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the database.
    arn: ?[]const u8 = null,

    /// The ID of the component.
    component_id: ?[]const u8 = null,

    /// The Amazon Resource Names of the connected AWS Systems Manager for SAP
    /// components.
    connected_component_arns: ?[]const []const u8 = null,

    /// The credentials of the database.
    credentials: ?[]const ApplicationCredential = null,

    /// The ID of the SAP HANA database.
    database_id: ?[]const u8 = null,

    /// The name of the database.
    database_name: ?[]const u8 = null,

    /// The type of the database.
    database_type: ?DatabaseType = null,

    /// The time at which the database was last updated.
    last_updated: ?i64 = null,

    /// The primary host of the database.
    primary_host: ?[]const u8 = null,

    /// The SQL port of the database.
    sql_port: ?i32 = null,

    /// The status of the database.
    status: ?DatabaseStatus = null,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .arn = "Arn",
        .component_id = "ComponentId",
        .connected_component_arns = "ConnectedComponentArns",
        .credentials = "Credentials",
        .database_id = "DatabaseId",
        .database_name = "DatabaseName",
        .database_type = "DatabaseType",
        .last_updated = "LastUpdated",
        .primary_host = "PrimaryHost",
        .sql_port = "SQLPort",
        .status = "Status",
    };
};
