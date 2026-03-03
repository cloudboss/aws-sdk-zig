const AllowMessages = @import("allow_messages.zig").AllowMessages;
const EndpointAttributes = @import("endpoint_attributes.zig").EndpointAttributes;
const EndpointState = @import("endpoint_state.zig").EndpointState;
const AppInstanceUserEndpointType = @import("app_instance_user_endpoint_type.zig").AppInstanceUserEndpointType;

/// An endpoint under an Amazon Chime `AppInstanceUser` that receives messages
/// for a user. For push notifications, the endpoint is a mobile device used to
/// receive mobile push notifications for a user.
pub const AppInstanceUserEndpoint = struct {
    /// Boolean that controls whether the `AppInstanceUserEndpoint` is opted in to
    /// receive messages. `ALL` indicates the endpoint will receive all messages.
    /// `NONE` indicates the endpoint will receive no messages.
    allow_messages: ?AllowMessages = null,

    /// The ARN of the `AppInstanceUser`.
    app_instance_user_arn: ?[]const u8 = null,

    /// The time at which an `AppInstanceUserEndpoint` was created.
    created_timestamp: ?i64 = null,

    /// The attributes of an `Endpoint`.
    endpoint_attributes: ?EndpointAttributes = null,

    /// The unique identifier of the `AppInstanceUserEndpoint`.
    endpoint_id: ?[]const u8 = null,

    /// A read-only field that represents the state of an `AppInstanceUserEndpoint`.
    /// Supported values:
    ///
    /// * `ACTIVE`: The `AppInstanceUserEndpoint` is active and able to receive
    ///   messages. When `ACTIVE`, the `EndpointStatusReason` remains empty.
    ///
    /// * `INACTIVE`: The `AppInstanceUserEndpoint` is inactive and can't receive
    ///   message. When `INACTIVE`, the corresponding reason will be
    /// conveyed through `EndpointStatusReason`.
    ///
    /// * `INVALID_DEVICE_TOKEN` indicates that an `AppInstanceUserEndpoint` is
    ///   `INACTIVE` due to invalid device token
    ///
    /// * `INVALID_PINPOINT_ARN` indicates that an `AppInstanceUserEndpoint` is
    ///   `INACTIVE` due to an invalid pinpoint ARN that was input
    /// through the `ResourceArn` field.
    endpoint_state: ?EndpointState = null,

    /// The time at which an `AppInstanceUserEndpoint` was last updated.
    last_updated_timestamp: ?i64 = null,

    /// The name of the `AppInstanceUserEndpoint`.
    name: ?[]const u8 = null,

    /// The ARN of the resource to which the endpoint belongs.
    resource_arn: ?[]const u8 = null,

    /// The type of the `AppInstanceUserEndpoint`.
    @"type": ?AppInstanceUserEndpointType = null,

    pub const json_field_names = .{
        .allow_messages = "AllowMessages",
        .app_instance_user_arn = "AppInstanceUserArn",
        .created_timestamp = "CreatedTimestamp",
        .endpoint_attributes = "EndpointAttributes",
        .endpoint_id = "EndpointId",
        .endpoint_state = "EndpointState",
        .last_updated_timestamp = "LastUpdatedTimestamp",
        .name = "Name",
        .resource_arn = "ResourceArn",
        .@"type" = "Type",
    };
};
