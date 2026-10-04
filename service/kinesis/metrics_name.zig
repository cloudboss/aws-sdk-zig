const std = @import("std");

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
        .incoming_bytes = "IncomingBytes",
        .incoming_records = "IncomingRecords",
        .outgoing_bytes = "OutgoingBytes",
        .outgoing_records = "OutgoingRecords",
        .write_provisioned_throughput_exceeded = "WriteProvisionedThroughputExceeded",
        .read_provisioned_throughput_exceeded = "ReadProvisionedThroughputExceeded",
        .iterator_age_milliseconds = "IteratorAgeMilliseconds",
        .all = "ALL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .incoming_bytes => "IncomingBytes",
            .incoming_records => "IncomingRecords",
            .outgoing_bytes => "OutgoingBytes",
            .outgoing_records => "OutgoingRecords",
            .write_provisioned_throughput_exceeded => "WriteProvisionedThroughputExceeded",
            .read_provisioned_throughput_exceeded => "ReadProvisionedThroughputExceeded",
            .iterator_age_milliseconds => "IteratorAgeMilliseconds",
            .all => "ALL",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
