const std = @import("std");

pub const DeliveryStreamType = enum {
    direct_put,
    kinesis_stream_as_source,
    msk_as_source,
    database_as_source,

    pub const json_field_names = .{
        .direct_put = "DirectPut",
        .kinesis_stream_as_source = "KinesisStreamAsSource",
        .msk_as_source = "MSKAsSource",
        .database_as_source = "DatabaseAsSource",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .direct_put => "DirectPut",
            .kinesis_stream_as_source => "KinesisStreamAsSource",
            .msk_as_source => "MSKAsSource",
            .database_as_source => "DatabaseAsSource",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
