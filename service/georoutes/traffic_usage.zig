const std = @import("std");

pub const TrafficUsage = enum {
    ignore_traffic_data,
    use_traffic_data,

    pub const json_field_names = .{
        .ignore_traffic_data = "IgnoreTrafficData",
        .use_traffic_data = "UseTrafficData",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ignore_traffic_data => "IgnoreTrafficData",
            .use_traffic_data => "UseTrafficData",
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
