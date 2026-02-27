/// Rtmp Output Certificate Mode
pub const RtmpOutputCertificateMode = enum {
    self_signed,
    verify_authenticity,

    pub const json_field_names = .{
        .self_signed = "SELF_SIGNED",
        .verify_authenticity = "VERIFY_AUTHENTICITY",
    };
};
