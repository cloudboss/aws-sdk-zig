pub const MemberDisabledReason = enum {
    volume_too_high,
    volume_unknown,

    pub const json_field_names = .{
        .volume_too_high = "VOLUME_TOO_HIGH",
        .volume_unknown = "VOLUME_UNKNOWN",
    };
};
