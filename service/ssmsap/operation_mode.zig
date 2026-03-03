const std = @import("std");

pub const OperationMode = enum {
    primary,
    logreplay,
    delta_datashipping,
    logreplay_readaccess,
    none,

    pub const json_field_names = .{
        .primary = "PRIMARY",
        .logreplay = "LOGREPLAY",
        .delta_datashipping = "DELTA_DATASHIPPING",
        .logreplay_readaccess = "LOGREPLAY_READACCESS",
        .none = "NONE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .primary => "PRIMARY",
            .logreplay => "LOGREPLAY",
            .delta_datashipping => "DELTA_DATASHIPPING",
            .logreplay_readaccess => "LOGREPLAY_READACCESS",
            .none => "NONE",
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
