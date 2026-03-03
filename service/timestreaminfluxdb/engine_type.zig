const std = @import("std");

pub const EngineType = enum {
    influxdb_v2,
    influxdb_v3_core,
    influxdb_v3_enterprise,

    pub const json_field_names = .{
        .influxdb_v2 = "INFLUXDB_V2",
        .influxdb_v3_core = "INFLUXDB_V3_CORE",
        .influxdb_v3_enterprise = "INFLUXDB_V3_ENTERPRISE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .influxdb_v2 => "INFLUXDB_V2",
            .influxdb_v3_core => "INFLUXDB_V3_CORE",
            .influxdb_v3_enterprise => "INFLUXDB_V3_ENTERPRISE",
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
