const std = @import("std");

pub const SearchContactsTimeRangeType = enum {
    initiation_timestamp,
    scheduled_timestamp,
    connected_to_agent_timestamp,
    disconnect_timestamp,
    enqueue_timestamp,

    pub const json_field_names = .{
        .initiation_timestamp = "INITIATION_TIMESTAMP",
        .scheduled_timestamp = "SCHEDULED_TIMESTAMP",
        .connected_to_agent_timestamp = "CONNECTED_TO_AGENT_TIMESTAMP",
        .disconnect_timestamp = "DISCONNECT_TIMESTAMP",
        .enqueue_timestamp = "ENQUEUE_TIMESTAMP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .initiation_timestamp => "INITIATION_TIMESTAMP",
            .scheduled_timestamp => "SCHEDULED_TIMESTAMP",
            .connected_to_agent_timestamp => "CONNECTED_TO_AGENT_TIMESTAMP",
            .disconnect_timestamp => "DISCONNECT_TIMESTAMP",
            .enqueue_timestamp => "ENQUEUE_TIMESTAMP",
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
