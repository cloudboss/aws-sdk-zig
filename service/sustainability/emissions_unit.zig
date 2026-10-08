const std = @import("std");

/// Specifies the unit of measurement for emissions.
pub const EmissionsUnit = enum {
    /// Metric tons of carbon dioxide-equivalent (MTCO2e).
    mt_co2_e,

    pub const json_field_names = .{
        .mt_co2_e = "MTCO2e",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .mt_co2_e => "MTCO2e",
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
