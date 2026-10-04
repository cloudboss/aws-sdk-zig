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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
