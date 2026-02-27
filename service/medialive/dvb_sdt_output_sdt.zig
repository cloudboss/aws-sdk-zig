/// Dvb Sdt Output Sdt
pub const DvbSdtOutputSdt = enum {
    sdt_follow,
    sdt_follow_if_present,
    sdt_manual,
    sdt_none,

    pub const json_field_names = .{
        .sdt_follow = "SDT_FOLLOW",
        .sdt_follow_if_present = "SDT_FOLLOW_IF_PRESENT",
        .sdt_manual = "SDT_MANUAL",
        .sdt_none = "SDT_NONE",
    };
};
