const DatastoreStatus = @import("datastore_status.zig").DatastoreStatus;
const LosslessStorageFormat = @import("lossless_storage_format.zig").LosslessStorageFormat;

/// The properties associated with the data store.
pub const DatastoreProperties = struct {
    /// The timestamp when the data store was created.
    created_at: ?i64 = null,

    /// The Amazon Resource Name (ARN) for the data store.
    datastore_arn: ?[]const u8 = null,

    /// The data store identifier.
    datastore_id: []const u8,

    /// The data store name.
    datastore_name: []const u8,

    /// The data store status.
    datastore_status: DatastoreStatus,

    /// The Amazon Resource Name (ARN) assigned to the Key Management Service (KMS)
    /// key for accessing encrypted data.
    kms_key_arn: ?[]const u8 = null,

    /// The ARN of the authorizer's Lambda function.
    lambda_authorizer_arn: ?[]const u8 = null,

    /// The datastore's lossless storage format.
    lossless_storage_format: ?LosslessStorageFormat = null,

    /// The timestamp when the data store was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .datastore_arn = "datastoreArn",
        .datastore_id = "datastoreId",
        .datastore_name = "datastoreName",
        .datastore_status = "datastoreStatus",
        .kms_key_arn = "kmsKeyArn",
        .lambda_authorizer_arn = "lambdaAuthorizerArn",
        .lossless_storage_format = "losslessStorageFormat",
        .updated_at = "updatedAt",
    };
};
