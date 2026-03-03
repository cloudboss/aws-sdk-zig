/// The LoRaWAN information used with the multicast session.
pub const LoRaWANMulticastSession = struct {
    dl_dr: ?i32 = null,

    dl_freq: ?i32 = null,

    /// The PingSlotPeriod value.
    ping_slot_period: ?i32 = null,

    session_start_time: ?i64 = null,

    session_timeout: ?i32 = null,

    pub const json_field_names = .{
        .dl_dr = "DlDr",
        .dl_freq = "DlFreq",
        .ping_slot_period = "PingSlotPeriod",
        .session_start_time = "SessionStartTime",
        .session_timeout = "SessionTimeout",
    };
};
