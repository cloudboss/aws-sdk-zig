const TransitGatewayRegistrationState = @import("transit_gateway_registration_state.zig").TransitGatewayRegistrationState;

/// Describes the status of a transit gateway registration.
pub const TransitGatewayRegistrationStateReason = struct {
    /// The code for the state reason.
    code: ?TransitGatewayRegistrationState,

    /// The message for the state reason.
    message: ?[]const u8,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
    };
};
