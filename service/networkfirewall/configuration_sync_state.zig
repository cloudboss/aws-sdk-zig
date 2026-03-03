const std = @import("std");

pub const ConfigurationSyncState = enum {
    pending,
    in_sync,
    capacity_constrained,

    pub const json_field_names = .{
        .pending = "PENDING",
        .in_sync = "IN_SYNC",
        .capacity_constrained = "CAPACITY_CONSTRAINED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .in_sync => "IN_SYNC",
            .capacity_constrained => "CAPACITY_CONSTRAINED",
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
