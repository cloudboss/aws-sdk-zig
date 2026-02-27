const DirectConnectGatewayAttachmentState = @import("direct_connect_gateway_attachment_state.zig").DirectConnectGatewayAttachmentState;
const DirectConnectGatewayAttachmentType = @import("direct_connect_gateway_attachment_type.zig").DirectConnectGatewayAttachmentType;

/// Information about an attachment between a Direct Connect gateway and a
/// virtual interface.
pub const DirectConnectGatewayAttachment = struct {
    /// The state of the attachment. The following are the possible values:
    ///
    /// * `attaching`: The initial state after a virtual interface is created using
    ///   the Direct Connect gateway.
    ///
    /// * `attached`: The Direct Connect gateway and virtual interface are attached
    ///   and ready to pass traffic.
    ///
    /// * `detaching`: The initial state after calling DeleteVirtualInterface.
    ///
    /// * `detached`: The virtual interface is detached from the Direct Connect
    ///   gateway. Traffic flow between the Direct Connect gateway and virtual
    ///   interface is stopped.
    attachment_state: ?DirectConnectGatewayAttachmentState,

    /// The type of attachment.
    attachment_type: ?DirectConnectGatewayAttachmentType,

    /// The ID of the Direct Connect gateway.
    direct_connect_gateway_id: ?[]const u8,

    /// The error message if the state of an object failed to advance.
    state_change_error: ?[]const u8,

    /// The ID of the virtual interface.
    virtual_interface_id: ?[]const u8,

    /// The ID of the Amazon Web Services account that owns the virtual interface.
    virtual_interface_owner_account: ?[]const u8,

    /// The Amazon Web Services Region where the virtual interface is located.
    virtual_interface_region: ?[]const u8,

    pub const json_field_names = .{
        .attachment_state = "attachmentState",
        .attachment_type = "attachmentType",
        .direct_connect_gateway_id = "directConnectGatewayId",
        .state_change_error = "stateChangeError",
        .virtual_interface_id = "virtualInterfaceId",
        .virtual_interface_owner_account = "virtualInterfaceOwnerAccount",
        .virtual_interface_region = "virtualInterfaceRegion",
    };
};
