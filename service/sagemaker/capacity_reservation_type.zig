pub const CapacityReservationType = enum {
    odcr,
    crg,

    pub const json_field_names = .{
        .odcr = "ODCR",
        .crg = "CRG",
    };
};
