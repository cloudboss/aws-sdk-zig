const std = @import("std");

pub const StorageVirtualMachineSubtype = enum {
    default,
    dp_destination,
    sync_destination,
    sync_source,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .dp_destination = "DP_DESTINATION",
        .sync_destination = "SYNC_DESTINATION",
        .sync_source = "SYNC_SOURCE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .default => "DEFAULT",
            .dp_destination => "DP_DESTINATION",
            .sync_destination => "SYNC_DESTINATION",
            .sync_source => "SYNC_SOURCE",
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
