const std = @import("std");

pub const DbStorageType = enum {
    influx_io_included_t1,
    influx_io_included_t2,
    influx_io_included_t3,

    pub const json_field_names = .{
        .influx_io_included_t1 = "InfluxIOIncludedT1",
        .influx_io_included_t2 = "InfluxIOIncludedT2",
        .influx_io_included_t3 = "InfluxIOIncludedT3",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .influx_io_included_t1 => "InfluxIOIncludedT1",
            .influx_io_included_t2 => "InfluxIOIncludedT2",
            .influx_io_included_t3 => "InfluxIOIncludedT3",
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
