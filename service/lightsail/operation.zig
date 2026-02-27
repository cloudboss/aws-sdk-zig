const ResourceLocation = @import("resource_location.zig").ResourceLocation;
const OperationType = @import("operation_type.zig").OperationType;
const ResourceType = @import("resource_type.zig").ResourceType;
const OperationStatus = @import("operation_status.zig").OperationStatus;

/// Describes the API operation.
pub const Operation = struct {
    /// The timestamp when the operation was initialized (`1479816991.349`).
    created_at: ?i64,

    /// The error code.
    error_code: ?[]const u8,

    /// The error details.
    error_details: ?[]const u8,

    /// The ID of the operation.
    id: ?[]const u8,

    /// A Boolean value indicating whether the operation is terminal.
    is_terminal: ?bool,

    /// The Amazon Web Services Region and Availability Zone.
    location: ?ResourceLocation,

    /// Details about the operation (`Debian-1GB-Ohio-1`).
    operation_details: ?[]const u8,

    /// The type of operation.
    operation_type: ?OperationType,

    /// The resource name.
    resource_name: ?[]const u8,

    /// The resource type.
    resource_type: ?ResourceType,

    /// The status of the operation.
    status: ?OperationStatus,

    /// The timestamp when the status was changed (`1479816991.349`).
    status_changed_at: ?i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .error_code = "errorCode",
        .error_details = "errorDetails",
        .id = "id",
        .is_terminal = "isTerminal",
        .location = "location",
        .operation_details = "operationDetails",
        .operation_type = "operationType",
        .resource_name = "resourceName",
        .resource_type = "resourceType",
        .status = "status",
        .status_changed_at = "statusChangedAt",
    };
};
