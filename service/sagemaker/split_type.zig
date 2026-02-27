pub const SplitType = enum {
    none,
    line,
    recordio,
    tfrecord,

    pub const json_field_names = .{
        .none = "NONE",
        .line = "LINE",
        .recordio = "RECORDIO",
        .tfrecord = "TFRECORD",
    };
};
