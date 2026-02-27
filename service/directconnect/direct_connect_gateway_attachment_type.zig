pub const DirectConnectGatewayAttachmentType = enum {
    transit_virtual_interface,
    private_virtual_interface,

    pub const json_field_names = .{
        .transit_virtual_interface = "TransitVirtualInterface",
        .private_virtual_interface = "PrivateVirtualInterface",
    };
};
