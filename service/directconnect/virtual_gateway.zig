/// Information about a virtual private gateway for a private virtual interface.
pub const VirtualGateway = struct {
    /// The ID of the virtual private gateway.
    virtual_gateway_id: ?[]const u8 = null,

    /// The state of the virtual private gateway. The following are the possible
    /// values:
    ///
    /// * `pending`: Initial state after creating the virtual private gateway.
    ///
    /// * `available`: Ready for use by a private virtual interface.
    ///
    /// * `deleting`: Initial state after deleting the virtual private gateway.
    ///
    /// * `deleted`: The virtual private gateway is deleted. The private virtual
    ///   interface is unable to send traffic over this gateway.
    virtual_gateway_state: ?[]const u8 = null,

    pub const json_field_names = .{
        .virtual_gateway_id = "virtualGatewayId",
        .virtual_gateway_state = "virtualGatewayState",
    };
};
