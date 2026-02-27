pub const DeltaTargetCompressionType = enum {
    uncompressed,
    snappy,

    pub const json_field_names = .{
        .uncompressed = "UNCOMPRESSED",
        .snappy = "SNAPPY",
    };
};
