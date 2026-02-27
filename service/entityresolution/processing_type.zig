pub const ProcessingType = enum {
    consistent,
    eventual,
    eventual_no_lookup,

    pub const json_field_names = .{
        .consistent = "CONSISTENT",
        .eventual = "EVENTUAL",
        .eventual_no_lookup = "EVENTUAL_NO_LOOKUP",
    };
};
