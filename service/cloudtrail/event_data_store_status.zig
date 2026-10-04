const std = @import("std");

pub const EventDataStoreStatus = enum {
    created,
    enabled,
    pending_deletion,
    starting_ingestion,
    stopping_ingestion,
    stopped_ingestion,

    pub const json_field_names = .{
        .created = "CREATED",
        .enabled = "ENABLED",
        .pending_deletion = "PENDING_DELETION",
        .starting_ingestion = "STARTING_INGESTION",
        .stopping_ingestion = "STOPPING_INGESTION",
        .stopped_ingestion = "STOPPED_INGESTION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .created => "CREATED",
            .enabled => "ENABLED",
            .pending_deletion => "PENDING_DELETION",
            .starting_ingestion => "STARTING_INGESTION",
            .stopping_ingestion => "STOPPING_INGESTION",
            .stopped_ingestion => "STOPPED_INGESTION",
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
