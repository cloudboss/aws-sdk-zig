/// The LoRaWAN information used with the multicast session.
pub const LoRaWANMulticastSession = struct {
    dl_dr: ?i32,

    dl_freq: ?i32,

    /// The PingSlotPeriod value.
    ping_slot_period: ?i32,

    session_start_time: ?i64,

    session_timeout: ?i32,

    pub const json_field_names = .{
        .dl_dr = "DlDr",
        .dl_freq = "DlFreq",
        .ping_slot_period = "PingSlotPeriod",
        .session_start_time = "SessionStartTime",
        .session_timeout = "SessionTimeout",
    };
};
