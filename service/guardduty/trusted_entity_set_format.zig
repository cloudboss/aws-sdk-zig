pub const TrustedEntitySetFormat = enum {
    txt,
    stix,
    otx_csv,
    alien_vault,
    proof_point,
    fire_eye,

    pub const json_field_names = .{
        .txt = "TXT",
        .stix = "STIX",
        .otx_csv = "OTX_CSV",
        .alien_vault = "ALIEN_VAULT",
        .proof_point = "PROOF_POINT",
        .fire_eye = "FIRE_EYE",
    };
};
