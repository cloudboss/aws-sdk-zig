pub const DataFormat = enum {
    avro,
    json,
    protobuf,

    pub const json_field_names = .{
        .avro = "AVRO",
        .json = "JSON",
        .protobuf = "PROTOBUF",
    };
};
