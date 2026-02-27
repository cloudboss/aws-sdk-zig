pub const EBSMetricName = enum {
    volume_read_ops_per_second,
    volume_write_ops_per_second,
    volume_read_bytes_per_second,
    volume_write_bytes_per_second,

    pub const json_field_names = .{
        .volume_read_ops_per_second = "VOLUME_READ_OPS_PER_SECOND",
        .volume_write_ops_per_second = "VOLUME_WRITE_OPS_PER_SECOND",
        .volume_read_bytes_per_second = "VOLUME_READ_BYTES_PER_SECOND",
        .volume_write_bytes_per_second = "VOLUME_WRITE_BYTES_PER_SECOND",
    };
};
