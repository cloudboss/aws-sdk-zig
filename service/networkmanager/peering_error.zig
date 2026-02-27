const PeeringErrorCode = @import("peering_error_code.zig").PeeringErrorCode;
const PermissionsErrorContext = @import("permissions_error_context.zig").PermissionsErrorContext;

/// Describes an error associated with a peering request.
pub const PeeringError = struct {
    /// The error code for the peering request.
    code: ?PeeringErrorCode,

    /// The message associated with the error `code`.
    message: ?[]const u8,

    /// Provides additional information about missing permissions for the peering
    /// error.
    missing_permissions_context: ?PermissionsErrorContext,

    /// The ID of the Peering request.
    request_id: ?[]const u8,

    /// The ARN of the requested peering resource.
    resource_arn: ?[]const u8,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
        .missing_permissions_context = "MissingPermissionsContext",
        .request_id = "RequestId",
        .resource_arn = "ResourceArn",
    };
};
