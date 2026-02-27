pub const DataDistributionType = enum {
    fullyreplicated,
    shardedbys3_key,

    pub const json_field_names = .{
        .fullyreplicated = "FULLYREPLICATED",
        .shardedbys3_key = "SHARDEDBYS3KEY",
    };
};
