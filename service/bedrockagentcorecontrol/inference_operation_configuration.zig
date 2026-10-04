const ModelEntry = @import("model_entry.zig").ModelEntry;

/// The configuration for a specific inference operation, including its request
/// path and the models that the operation supports.
pub const InferenceOperationConfiguration = struct {
    /// The list of models supported for this operation.
    models: ?[]const ModelEntry = null,

    /// The request path for this operation (for example, `/v1/messages` or
    /// `/v1/responses`).
    path: []const u8,

    /// The provider path to forward requests to, if it differs from the request
    /// path. For example, `/anthropic/v1/messages` when the provider expects a
    /// different path than the client-facing `/v1/messages`.
    provider_path: ?[]const u8 = null,

    pub const json_field_names = .{
        .models = "models",
        .path = "path",
        .provider_path = "providerPath",
    };
};
