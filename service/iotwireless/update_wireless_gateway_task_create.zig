const LoRaWANUpdateGatewayTaskCreate = @import("lo_ra_wan_update_gateway_task_create.zig").LoRaWANUpdateGatewayTaskCreate;

/// UpdateWirelessGatewayTaskCreate object.
pub const UpdateWirelessGatewayTaskCreate = struct {
    /// The properties that relate to the LoRaWAN wireless gateway.
    lo_ra_wan: ?LoRaWANUpdateGatewayTaskCreate = null,

    /// The IAM role used to read data from the S3 bucket.
    update_data_role: ?[]const u8 = null,

    /// The link to the S3 bucket.
    update_data_source: ?[]const u8 = null,

    pub const json_field_names = .{
        .lo_ra_wan = "LoRaWAN",
        .update_data_role = "UpdateDataRole",
        .update_data_source = "UpdateDataSource",
    };
};
