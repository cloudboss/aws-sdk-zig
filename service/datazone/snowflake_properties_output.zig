const IdentityMapping = @import("identity_mapping.zig").IdentityMapping;
const LineageSyncOutput = @import("lineage_sync_output.zig").LineageSyncOutput;
const ConnectionStatus = @import("connection_status.zig").ConnectionStatus;

/// Contains the Snowflake-specific settings returned for an existing
/// connection, including the current role, identity mapping, lineage sync
/// state, and connection status.
pub const SnowflakePropertiesOutput = struct {
    /// An error message returned if the Snowflake connection failed to establish or
    /// validate.
    error_message: ?[]const u8 = null,

    /// The identity mapping configuration for the Snowflake connection.
    identity_mapping: IdentityMapping,

    /// The lineage sync configuration for the Snowflake connection.
    lineage_sync: LineageSyncOutput,

    /// The Snowflake role used to access Snowflake resources.
    snowflake_role: []const u8,

    /// The status of the Snowflake connection.
    status: ConnectionStatus,

    pub const json_field_names = .{
        .error_message = "errorMessage",
        .identity_mapping = "identityMapping",
        .lineage_sync = "lineageSync",
        .snowflake_role = "snowflakeRole",
        .status = "status",
    };
};
