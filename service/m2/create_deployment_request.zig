pub const CreateDeploymentRequest = struct {
    /// The application identifier.
    application_id: []const u8,

    /// The version of the application to deploy.
    application_version: i32,

    /// Unique, case-sensitive identifier you provide to ensure the idempotency of
    /// the request
    /// to create a deployment. The service generates the clientToken when the API
    /// call is
    /// triggered. The token expires after one hour, so if you retry the API within
    /// this timeframe
    /// with the same clientToken, you will get the same response. The service also
    /// handles
    /// deleting the clientToken after it expires.
    client_token: ?[]const u8 = null,

    /// The identifier of the runtime environment where you want to deploy this
    /// application.
    environment_id: []const u8,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .application_version = "applicationVersion",
        .client_token = "clientToken",
        .environment_id = "environmentId",
    };
};
