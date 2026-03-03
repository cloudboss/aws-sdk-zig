const DatastoreStatus = @import("datastore_status.zig").DatastoreStatus;
const FHIRVersion = @import("fhir_version.zig").FHIRVersion;
const ErrorCause = @import("error_cause.zig").ErrorCause;
const IdentityProviderConfiguration = @import("identity_provider_configuration.zig").IdentityProviderConfiguration;
const PreloadDataConfig = @import("preload_data_config.zig").PreloadDataConfig;
const SseConfiguration = @import("sse_configuration.zig").SseConfiguration;

/// The data store properties.
pub const DatastoreProperties = struct {
    /// The time the data store was created.
    created_at: ?i64 = null,

    /// The Amazon Resource Name (ARN) used in the creation of the data store.
    datastore_arn: []const u8,

    /// The AWS endpoint for the data store.
    datastore_endpoint: []const u8,

    /// The data store identifier.
    datastore_id: []const u8,

    /// The data store name.
    datastore_name: ?[]const u8 = null,

    /// The data store status.
    datastore_status: DatastoreStatus,

    /// The FHIR release version supported by the data store. Current support is for
    /// version
    /// `R4`.
    datastore_type_version: FHIRVersion,

    /// The error cause for the current data store operation.
    error_cause: ?ErrorCause = null,

    /// The identity provider selected during data store creation.
    identity_provider_configuration: ?IdentityProviderConfiguration = null,

    /// The preloaded Synthea data configuration for the data store.
    preload_data_config: ?PreloadDataConfig = null,

    /// The server-side encryption key configuration for a customer provided
    /// encryption
    /// key.
    sse_configuration: ?SseConfiguration = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .datastore_arn = "DatastoreArn",
        .datastore_endpoint = "DatastoreEndpoint",
        .datastore_id = "DatastoreId",
        .datastore_name = "DatastoreName",
        .datastore_status = "DatastoreStatus",
        .datastore_type_version = "DatastoreTypeVersion",
        .error_cause = "ErrorCause",
        .identity_provider_configuration = "IdentityProviderConfiguration",
        .preload_data_config = "PreloadDataConfig",
        .sse_configuration = "SseConfiguration",
    };
};
