const AuthType = @import("auth_type.zig").AuthType;

/// The connection parameters for an OneDrive data source. Provide these
/// parameters in the `DataSourceParameters` object when you create or update a
/// data source that uses OneDrive.
pub const OneDriveParameters = struct {
    /// The authentication type for the OneDrive data source. Valid values include:
    ///
    /// * `TWO_LEGGED_OAUTH` – Server-to-server authentication using client
    ///   credentials that do not require user interaction.
    ///
    /// * `THREE_LEGGED_OAUTH` – Interactive OAuth that requires user consent.
    auth_type: ?AuthType = null,

    /// The client ID for the OneDrive data source.
    client_id: ?[]const u8 = null,

    /// The tenant ID for the OneDrive data source.
    tenant_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .auth_type = "AuthType",
        .client_id = "ClientId",
        .tenant_id = "TenantId",
    };
};
