/// Eac3 Attenuation Control
pub const Eac3AttenuationControl = enum {
    attenuate_3_db,
    none,

    pub const json_field_names = .{
        .attenuate_3_db = "ATTENUATE_3_DB",
        .none = "NONE",
    };
};
