/// Beaconing parameters for configuring the wireless gateways.
pub const Beaconing = struct {
    /// The data rate for gateways that are sending the beacons.
    data_rate: ?i32 = null,

    /// The frequency list for the gateways to send the beacons.
    frequencies: ?[]const i32 = null,

    pub const json_field_names = .{
        .data_rate = "DataRate",
        .frequencies = "Frequencies",
    };
};
