pub const FillPolicy = enum {
    full_avail_only,
    partial_avail,

    pub const json_field_names = .{
        .full_avail_only = "FULL_AVAIL_ONLY",
        .partial_avail = "PARTIAL_AVAIL",
    };
};
