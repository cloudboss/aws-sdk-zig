const std = @import("std");

pub const ListDevicesSortBy = enum {
    device_id,
    created_time,
    name,
    device_aggregated_status,

    pub const json_field_names = .{
        .device_id = "DEVICE_ID",
        .created_time = "CREATED_TIME",
        .name = "NAME",
        .device_aggregated_status = "DEVICE_AGGREGATED_STATUS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .device_id => "DEVICE_ID",
            .created_time => "CREATED_TIME",
            .name => "NAME",
            .device_aggregated_status => "DEVICE_AGGREGATED_STATUS",
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
