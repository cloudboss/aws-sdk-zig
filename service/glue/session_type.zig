const std = @import("std");

pub const SessionType = enum {
    livy,
    spark_connect,

    pub const json_field_names = .{
        .livy = "LIVY",
        .spark_connect = "SPARK_CONNECT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .livy => "LIVY",
            .spark_connect => "SPARK_CONNECT",
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
