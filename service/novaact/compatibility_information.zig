/// Information about client compatibility and supported model versions.
pub const CompatibilityInformation = struct {
    /// The client compatibility version that was requested.
    client_compatibility_version: i32,

    /// Additional information about compatibility requirements or recommendations.
    message: ?[]const u8 = null,

    /// A list of model IDs that are supported for the client compatibility version.
    supported_model_ids: []const []const u8,

    pub const json_field_names = .{
        .client_compatibility_version = "clientCompatibilityVersion",
        .message = "message",
        .supported_model_ids = "supportedModelIds",
    };
};
