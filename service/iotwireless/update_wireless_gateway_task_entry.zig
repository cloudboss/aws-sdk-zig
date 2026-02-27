const LoRaWANUpdateGatewayTaskEntry = @import("lo_ra_wan_update_gateway_task_entry.zig").LoRaWANUpdateGatewayTaskEntry;

/// UpdateWirelessGatewayTaskEntry object.
pub const UpdateWirelessGatewayTaskEntry = struct {
    /// The Amazon Resource Name of the resource.
    arn: ?[]const u8,

    /// The ID of the new wireless gateway task entry.
    id: ?[]const u8,

    /// The properties that relate to the LoRaWAN wireless gateway.
    lo_ra_wan: ?LoRaWANUpdateGatewayTaskEntry,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
        .lo_ra_wan = "LoRaWAN",
    };
};
