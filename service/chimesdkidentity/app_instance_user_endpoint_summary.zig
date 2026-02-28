const AllowMessages = @import("allow_messages.zig").AllowMessages;
const EndpointState = @import("endpoint_state.zig").EndpointState;
const AppInstanceUserEndpointType = @import("app_instance_user_endpoint_type.zig").AppInstanceUserEndpointType;

/// Summary of the details of an `AppInstanceUserEndpoint`.
pub const AppInstanceUserEndpointSummary = struct {
    /// BBoolean that controls whether the `AppInstanceUserEndpoint` is opted in to
    /// receive messages. `ALL` indicates the endpoint will receive all messages.
    /// `NONE` indicates the endpoint will receive no messages.
    allow_messages: ?AllowMessages,

    /// The ARN of the `AppInstanceUser`.
    app_instance_user_arn: ?[]const u8,

    /// The unique identifier of the `AppInstanceUserEndpoint`.
    endpoint_id: ?[]const u8,

    /// A read-only field that represent the state of an `AppInstanceUserEndpoint`.
    endpoint_state: ?EndpointState,

    /// The name of the `AppInstanceUserEndpoint`.
    name: ?[]const u8,

    /// The type of the `AppInstanceUserEndpoint`.
    @"type": ?AppInstanceUserEndpointType,

    pub const json_field_names = .{
        .allow_messages = "AllowMessages",
        .app_instance_user_arn = "AppInstanceUserArn",
        .endpoint_id = "EndpointId",
        .endpoint_state = "EndpointState",
        .name = "Name",
        .@"type" = "Type",
    };
};
