const BackendAPIAuthType = @import("backend_api_auth_type.zig").BackendAPIAuthType;
const BackendAPIConflictResolution = @import("backend_api_conflict_resolution.zig").BackendAPIConflictResolution;

/// The resource config for the data model, configured as a part of the Amplify
/// project.
pub const BackendAPIResourceConfig = struct {
    /// Additional authentication methods used to interact with your data models.
    additional_auth_types: ?[]const BackendAPIAuthType,

    /// The API name used to interact with the data model, configured as a part of
    /// your Amplify project.
    api_name: ?[]const u8,

    /// The conflict resolution strategy for your data stored in the data models.
    conflict_resolution: ?BackendAPIConflictResolution,

    /// The default authentication type for interacting with the configured data
    /// models in your Amplify project.
    default_auth_type: ?BackendAPIAuthType,

    /// The service used to provision and interact with the data model.
    service: ?[]const u8,

    /// The definition of the data model in the annotated transform of the GraphQL
    /// schema.
    transform_schema: ?[]const u8,

    pub const json_field_names = .{
        .additional_auth_types = "AdditionalAuthTypes",
        .api_name = "ApiName",
        .conflict_resolution = "ConflictResolution",
        .default_auth_type = "DefaultAuthType",
        .service = "Service",
        .transform_schema = "TransformSchema",
    };
};
