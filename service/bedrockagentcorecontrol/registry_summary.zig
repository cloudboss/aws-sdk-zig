const RegistryAuthorizerType = @import("registry_authorizer_type.zig").RegistryAuthorizerType;
const RegistryStatus = @import("registry_status.zig").RegistryStatus;

/// Contains summary information about a registry.
pub const RegistrySummary = struct {
    /// The type of authorizer used by the registry. This controls the authorization
    /// method for the Search and Invoke APIs used by consumers.
    ///
    /// * `CUSTOM_JWT` - Authorize with a bearer token.
    /// * `AWS_IAM` - Authorize with your Amazon Web Services IAM credentials.
    authorizer_type: ?RegistryAuthorizerType = null,

    /// The timestamp when the registry was created.
    created_at: i64,

    /// The description of the registry.
    description: ?[]const u8 = null,

    /// The name of the registry.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the registry.
    registry_arn: []const u8,

    /// The unique identifier of the registry.
    registry_id: []const u8,

    /// The current status of the registry. Possible values include `CREATING`,
    /// `READY`, `UPDATING`, `CREATE_FAILED`, `UPDATE_FAILED`, `DELETING`, and
    /// `DELETE_FAILED`.
    status: RegistryStatus,

    /// The reason for the current status, typically set when the status is a
    /// failure state.
    status_reason: ?[]const u8 = null,

    /// The timestamp when the registry was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .authorizer_type = "authorizerType",
        .created_at = "createdAt",
        .description = "description",
        .name = "name",
        .registry_arn = "registryArn",
        .registry_id = "registryId",
        .status = "status",
        .status_reason = "statusReason",
        .updated_at = "updatedAt",
    };
};
