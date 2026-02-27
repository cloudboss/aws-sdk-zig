pub const MetricsName = enum {
    incoming_bytes,
    incoming_records,
    outgoing_bytes,
    outgoing_records,
    write_provisioned_throughput_exceeded,
    read_provisioned_throughput_exceeded,
    iterator_age_milliseconds,
    all,

    pub const json_field_names = .{
        .incoming_bytes = "INCOMING_BYTES",
        .incoming_records = "INCOMING_RECORDS",
        .outgoing_bytes = "OUTGOING_BYTES",
        .outgoing_records = "OUTGOING_RECORDS",
        .write_provisioned_throughput_exceeded = "WRITE_PROVISIONED_THROUGHPUT_EXCEEDED",
        .read_provisioned_throughput_exceeded = "READ_PROVISIONED_THROUGHPUT_EXCEEDED",
        .iterator_age_milliseconds = "ITERATOR_AGE_MILLISECONDS",
        .all = "ALL",
    };
};
