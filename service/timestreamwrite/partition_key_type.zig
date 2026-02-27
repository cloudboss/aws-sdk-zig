pub const PartitionKeyType = enum {
    dimension,
    measure,

    pub const json_field_names = .{
        .dimension = "DIMENSION",
        .measure = "MEASURE",
    };
};
