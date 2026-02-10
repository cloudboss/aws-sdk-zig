const HaStatus = @import("ha_status.zig").HaStatus;
const SqlServerLicenseUsage = @import("sql_server_license_usage.zig").SqlServerLicenseUsage;
const Tag = @import("tag.zig").Tag;

/// Describes an Amazon EC2 instance that is enabled for SQL Server High
/// Availability standby
/// detection monitoring.
pub const RegisteredInstance = struct {
    /// The SQL Server High Availability status of the instance. Valid values are:
    ///
    /// * `processing` - The SQL Server High Availability status for the SQL Server
    ///   High Availability instance is being updated.
    ///
    /// * `active` - The SQL Server High Availability instance is an active node in
    ///   an SQL Server High Availability cluster.
    ///
    /// * `standby` - The SQL Server High Availability instance is a standby
    ///   failover node in an SQL Server High Availability
    /// cluster.
    ///
    /// * `invalid` - An error occurred due to misconfigured permissions, or unable
    /// to dertemine SQL Server High Availability status for the SQL Server High
    /// Availability instance.
    ha_status: ?HaStatus,

    /// The ID of the SQL Server High Availability instance.
    instance_id: ?[]const u8,

    /// The date and time when the instance's SQL Server High Availability status
    /// was last updated, in the ISO 8601 format
    /// in the UTC time zone (`YYYY-MM-DDThh:mm:ss.sssZ`).
    last_updated_time: ?i64,

    /// A brief description of the SQL Server High Availability status. If the
    /// instance is in the `invalid`
    /// High Availability status, this parameter includes the error message.
    processing_status: ?[]const u8,

    /// The ARN of the Secrets Manager secret containing the SQL Server access
    /// credentials for the SQL Server High Availability instance.
    /// If not specified, deafult local user credentials will be used by the Amazon
    /// Web Services Systems Manager agent.
    sql_server_credentials: ?[]const u8,

    /// The license type for the SQL Server license. Valid values include:
    ///
    /// * `full` - The SQL Server High Availability instance is using a full SQL
    ///   Server license.
    ///
    /// * `waived` - The SQL Server High Availability instance is waived from the
    ///   SQL Server license.
    sql_server_license_usage: ?SqlServerLicenseUsage,

    /// The tags assigned to the SQL Server High Availability instance.
    tags: ?[]const Tag,
};
