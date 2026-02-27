const GlobalIdentity = @import("global_identity.zig").GlobalIdentity;

/// GSM object for network measurement reports.
pub const GsmNmrObj = struct {
    /// GSM broadcast control channel.
    bcch: i32,

    /// GSM base station identity code (BSIC).
    bsic: i32,

    /// Global identity information of the GSM object.
    global_identity: ?GlobalIdentity,

    /// Rx level, which is the received signal power, measured in dBm
    /// (decibel-milliwatts).
    rx_level: ?i32,

    pub const json_field_names = .{
        .bcch = "Bcch",
        .bsic = "Bsic",
        .global_identity = "GlobalIdentity",
        .rx_level = "RxLevel",
    };
};
