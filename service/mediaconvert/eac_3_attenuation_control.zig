/// If set to ATTENUATE_3_DB, applies a 3 dB attenuation to the surround
/// channels. Only used for 3/2 coding mode.
pub const Eac3AttenuationControl = enum {
    attenuate_3_db,
    none,

    pub const json_field_names = .{
        .attenuate_3_db = "ATTENUATE_3_DB",
        .none = "NONE",
    };
};
