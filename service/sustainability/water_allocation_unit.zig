const std = @import("std");

/// Specifies the unit of measurement for allocation.
pub const WaterAllocationUnit = enum {
    /// Cubic meters of water.
    cubic_meters,

    pub const json_field_names = .{
        .cubic_meters = "m3",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cubic_meters => "m3",
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
