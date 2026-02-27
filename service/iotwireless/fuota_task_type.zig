/// The FUOTA task type.
pub const FuotaTaskType = enum {
    lo_ra_wan,

    pub const json_field_names = .{
        .lo_ra_wan = "LoRaWAN",
    };
};
