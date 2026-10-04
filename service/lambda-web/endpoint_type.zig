const std = @import("std");

/// The type of a web function endpoint. Possible values: `HomeRegion` (serves
/// from the Region where the function was created), `MultiRegion` (replicates
/// across chosen Regions and routes to the nearest), `PerRegion` (separate
/// endpoint per Region).
pub const EndpointType = enum {
    home_region,
    multi_region,
    per_region,

    pub const json_field_names = .{
        .home_region = "HomeRegion",
        .multi_region = "MultiRegion",
        .per_region = "PerRegion",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .home_region => "HomeRegion",
            .multi_region => "MultiRegion",
            .per_region => "PerRegion",
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
