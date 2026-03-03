const std = @import("std");

pub const EndPointType = enum {
    kafka_bootstrap_servers,

    pub const json_field_names = .{
        .kafka_bootstrap_servers = "KAFKA_BOOTSTRAP_SERVERS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .kafka_bootstrap_servers => "KAFKA_BOOTSTRAP_SERVERS",
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
