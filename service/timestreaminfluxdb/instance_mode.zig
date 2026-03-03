const std = @import("std");

pub const InstanceMode = enum {
    primary,
    standby,
    replica,
    ingest,
    query,
    compact,
    process,

    pub const json_field_names = .{
        .primary = "PRIMARY",
        .standby = "STANDBY",
        .replica = "REPLICA",
        .ingest = "INGEST",
        .query = "QUERY",
        .compact = "COMPACT",
        .process = "PROCESS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .primary => "PRIMARY",
            .standby => "STANDBY",
            .replica => "REPLICA",
            .ingest => "INGEST",
            .query => "QUERY",
            .compact => "COMPACT",
            .process => "PROCESS",
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
