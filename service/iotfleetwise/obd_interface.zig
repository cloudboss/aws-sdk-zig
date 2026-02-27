/// A network interface that specifies the on-board diagnostic (OBD) II network
/// protocol.
pub const ObdInterface = struct {
    /// The maximum number message requests per diagnostic trouble code per second.
    dtc_request_interval_seconds: i32 = 0,

    /// Whether the vehicle has a transmission control module (TCM).
    has_transmission_ecu: bool = false,

    /// The name of the interface.
    name: []const u8,

    /// The standard OBD II PID.
    obd_standard: ?[]const u8,

    /// The maximum number message requests per second.
    pid_request_interval_seconds: i32 = 0,

    /// The ID of the message requesting vehicle data.
    request_message_id: i32 = 0,

    /// Whether to use extended IDs in the message.
    use_extended_ids: bool = false,

    pub const json_field_names = .{
        .dtc_request_interval_seconds = "dtcRequestIntervalSeconds",
        .has_transmission_ecu = "hasTransmissionEcu",
        .name = "name",
        .obd_standard = "obdStandard",
        .pid_request_interval_seconds = "pidRequestIntervalSeconds",
        .request_message_id = "requestMessageId",
        .use_extended_ids = "useExtendedIds",
    };
};
