const EndpointStatus = @import("endpoint_status.zig").EndpointStatus;
const EndpointStatusReason = @import("endpoint_status_reason.zig").EndpointStatusReason;

/// A read-only field that represents the state of an `AppInstanceUserEndpoint`.
/// Supported values:
///
/// * `ACTIVE`: The `AppInstanceUserEndpoint` is active and able to receive
///   messages. When `ACTIVE`, the `EndpointStatusReason` remains empty.
///
/// * `INACTIVE`: The `AppInstanceUserEndpoint` is inactive and can't receive
/// message. When INACTIVE, the corresponding reason will be conveyed through
/// EndpointStatusReason.
///
/// * `INVALID_DEVICE_TOKEN` indicates that an `AppInstanceUserEndpoint` is
///   `INACTIVE` due to invalid device token
///
/// * `INVALID_PINPOINT_ARN` indicates that an `AppInstanceUserEndpoint` is
///   `INACTIVE` due to an invalid pinpoint ARN that was input through the
///   `ResourceArn` field.
pub const EndpointState = struct {
    /// Enum that indicates the Status of an `AppInstanceUserEndpoint`.
    status: EndpointStatus,

    /// The reason for the `EndpointStatus`.
    status_reason: ?EndpointStatusReason = null,

    pub const json_field_names = .{
        .status = "Status",
        .status_reason = "StatusReason",
    };
};
