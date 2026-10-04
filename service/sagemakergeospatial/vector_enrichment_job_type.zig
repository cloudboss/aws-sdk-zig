const std = @import("std");

pub const VectorEnrichmentJobType = enum {
    reverse_geocoding,
    map_matching,

    pub const json_field_names = .{
        .reverse_geocoding = "REVERSE_GEOCODING",
        .map_matching = "MAP_MATCHING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .reverse_geocoding => "REVERSE_GEOCODING",
            .map_matching => "MAP_MATCHING",
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
