const std = @import("std");

pub const DestinationType = enum {
    event_data_store,
    aws_service,

    pub const json_field_names = .{
        .event_data_store = "EVENT_DATA_STORE",
        .aws_service = "AWS_SERVICE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .event_data_store => "EVENT_DATA_STORE",
            .aws_service => "AWS_SERVICE",
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
