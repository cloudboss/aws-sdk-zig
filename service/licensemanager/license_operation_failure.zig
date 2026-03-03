const Metadata = @import("metadata.zig").Metadata;
const ResourceType = @import("resource_type.zig").ResourceType;

/// Describes the failure of a license operation.
pub const LicenseOperationFailure = struct {
    /// Error message.
    error_message: ?[]const u8 = null,

    /// Failure time.
    failure_time: ?i64 = null,

    /// Reserved.
    metadata_list: ?[]const Metadata = null,

    /// Name of the operation.
    operation_name: ?[]const u8 = null,

    /// The requester is "License Manager Automated Discovery".
    operation_requested_by: ?[]const u8 = null,

    /// Amazon Resource Name (ARN) of the resource.
    resource_arn: ?[]const u8 = null,

    /// ID of the Amazon Web Services account that owns the resource.
    resource_owner_id: ?[]const u8 = null,

    /// Resource type.
    resource_type: ?ResourceType = null,

    pub const json_field_names = .{
        .error_message = "ErrorMessage",
        .failure_time = "FailureTime",
        .metadata_list = "MetadataList",
        .operation_name = "OperationName",
        .operation_requested_by = "OperationRequestedBy",
        .resource_arn = "ResourceArn",
        .resource_owner_id = "ResourceOwnerId",
        .resource_type = "ResourceType",
    };
};
