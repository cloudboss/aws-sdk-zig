const std = @import("std");

/// This defines the type of ingestion request. This is returned as part of
/// create ingestion response.
pub const IngestionRequestType = enum {
    initial_ingestion,
    edit,
    incremental_refresh,
    full_refresh,

    pub const json_field_names = .{
        .initial_ingestion = "INITIAL_INGESTION",
        .edit = "EDIT",
        .incremental_refresh = "INCREMENTAL_REFRESH",
        .full_refresh = "FULL_REFRESH",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .initial_ingestion => "INITIAL_INGESTION",
            .edit => "EDIT",
            .incremental_refresh => "INCREMENTAL_REFRESH",
            .full_refresh => "FULL_REFRESH",
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
