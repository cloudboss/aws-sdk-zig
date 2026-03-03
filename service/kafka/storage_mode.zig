const std = @import("std");

/// Controls storage mode for various supported storage tiers.
pub const StorageMode = enum {
    local,
    tiered,

    pub const json_field_names = .{
        .local = "LOCAL",
        .tiered = "TIERED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .local => "LOCAL",
            .tiered => "TIERED",
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
