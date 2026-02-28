const ClientAuthenticationStatus = @import("client_authentication_status.zig").ClientAuthenticationStatus;
const ClientAuthenticationType = @import("client_authentication_type.zig").ClientAuthenticationType;

/// Contains information about a client authentication method for a directory.
pub const ClientAuthenticationSettingInfo = struct {
    /// The date and time when the status of the client authentication type was last
    /// updated.
    last_updated_date_time: ?i64,

    /// Whether the client authentication type is enabled or disabled for the
    /// specified
    /// directory.
    status: ?ClientAuthenticationStatus,

    /// The type of client authentication for the specified directory. If no type is
    /// specified, a
    /// list of all client authentication types that are supported for the directory
    /// is retrieved.
    type: ?ClientAuthenticationType,

    pub const json_field_names = .{
        .last_updated_date_time = "LastUpdatedDateTime",
        .status = "Status",
        .type = "Type",
    };
};
