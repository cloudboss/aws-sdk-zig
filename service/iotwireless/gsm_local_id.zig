/// GSM local ID information, which corresponds to the local identification
/// parameters of
/// a GSM cell.
pub const GsmLocalId = struct {
    /// GSM broadcast control channel.
    bcch: i32,

    /// GSM base station identity code (BSIC).
    bsic: i32,

    pub const json_field_names = .{
        .bcch = "Bcch",
        .bsic = "Bsic",
    };
};
