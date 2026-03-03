const AuthType = @import("auth_type.zig").AuthType;
const Persona = @import("persona.zig").Persona;
const AppAuthorizationStatus = @import("app_authorization_status.zig").AppAuthorizationStatus;
const Tenant = @import("tenant.zig").Tenant;

/// Contains information about an app authorization.
pub const AppAuthorization = struct {
    /// The name of the application.
    app: []const u8,

    /// The Amazon Resource Name (ARN) of the app authorization.
    app_authorization_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the app bundle for the app authorization.
    app_bundle_arn: []const u8,

    /// The authorization type.
    auth_type: AuthType,

    /// The application URL for the OAuth flow.
    auth_url: ?[]const u8 = null,

    /// The timestamp of when the app authorization was created.
    created_at: i64,

    /// The user persona of the app authorization.
    ///
    /// This field should always be `admin`.
    persona: ?Persona = null,

    /// The state of the app authorization.
    ///
    /// The following states are possible:
    ///
    /// * `PendingConnect`: The initial state of the app authorization. The app
    /// authorization is created but not yet connected.
    ///
    /// * `Connected`: The app authorization is connected to the application, and
    /// is ready to be used.
    ///
    /// * `ConnectionValidationFailed`: The app authorization received a
    /// validation exception when trying to connect to the application. If the app
    /// authorization is in this state, you should verify the configured credentials
    /// and try
    /// to connect the app authorization again.
    ///
    /// * `TokenAutoRotationFailed`: AppFabric failed to refresh the access token.
    ///   If
    /// the app authorization is in this state, you should try to reconnect the app
    /// authorization.
    status: AppAuthorizationStatus,

    /// Contains information about an application tenant, such as the application
    /// display name
    /// and identifier.
    tenant: Tenant,

    /// The timestamp of when the app authorization was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .app = "app",
        .app_authorization_arn = "appAuthorizationArn",
        .app_bundle_arn = "appBundleArn",
        .auth_type = "authType",
        .auth_url = "authUrl",
        .created_at = "createdAt",
        .persona = "persona",
        .status = "status",
        .tenant = "tenant",
        .updated_at = "updatedAt",
    };
};
