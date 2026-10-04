const AuthType = @import("auth_type.zig").AuthType;

/// The connection parameters for a Google Drive data source. Provide these
/// parameters in the `DataSourceParameters` object when you create or update a
/// data source that uses Google Drive.
pub const GoogleDriveParameters = struct {
    /// The authentication type for the Google Drive data source. Valid values
    /// include:
    ///
    /// * `SERVICE_ACCOUNT` – Server-to-server authentication using a Google service
    ///   account key.
    ///
    /// * `THREE_LEGGED_OAUTH` – Interactive OAuth that requires user consent.
    auth_type: ?AuthType = null,

    pub const json_field_names = .{
        .auth_type = "AuthType",
    };
};
