const std = @import("std");

pub const FleetIndexingApi = enum {
    get_thing_connectivity_data,

    pub const json_field_names = .{
        .get_thing_connectivity_data = "GET_THING_CONNECTIVITY_DATA",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .get_thing_connectivity_data => "GET_THING_CONNECTIVITY_DATA",
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
