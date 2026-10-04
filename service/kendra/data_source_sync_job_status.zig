const std = @import("std");

pub const DataSourceSyncJobStatus = enum {
    failed,
    succeeded,
    syncing,
    incomplete,
    stopping,
    aborted,
    syncing_indexing,

    pub const json_field_names = .{
        .failed = "FAILED",
        .succeeded = "SUCCEEDED",
        .syncing = "SYNCING",
        .incomplete = "INCOMPLETE",
        .stopping = "STOPPING",
        .aborted = "ABORTED",
        .syncing_indexing = "SYNCING_INDEXING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .failed => "FAILED",
            .succeeded => "SUCCEEDED",
            .syncing => "SYNCING",
            .incomplete => "INCOMPLETE",
            .stopping => "STOPPING",
            .aborted => "ABORTED",
            .syncing_indexing => "SYNCING_INDEXING",
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
