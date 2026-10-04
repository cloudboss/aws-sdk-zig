const std = @import("std");

/// The name of an opt-in feature. Valid values: `NETWORK_SCANNING`.
pub const FeatureName = enum {
    network_scanning,

    pub const json_field_names = .{
        .network_scanning = "NETWORK_SCANNING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .network_scanning => "NETWORK_SCANNING",
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
