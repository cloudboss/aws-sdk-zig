const LoRaWANUpdateGatewayTaskCreate = @import("lo_ra_wan_update_gateway_task_create.zig").LoRaWANUpdateGatewayTaskCreate;

/// UpdateWirelessGatewayTaskCreate object.
pub const UpdateWirelessGatewayTaskCreate = struct {
    /// The properties that relate to the LoRaWAN wireless gateway.
    lo_ra_wan: ?LoRaWANUpdateGatewayTaskCreate,

    /// The IAM role used to read data from the S3 bucket.
    update_data_role: ?[]const u8,

    /// The link to the S3 bucket.
    update_data_source: ?[]const u8,

    pub const json_field_names = .{
        .lo_ra_wan = "LoRaWAN",
        .update_data_role = "UpdateDataRole",
        .update_data_source = "UpdateDataSource",
    };
};
