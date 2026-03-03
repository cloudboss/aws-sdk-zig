const std = @import("std");

pub const WorkloadInsightsMetric = enum {
    timeouts,
    retransmissions,
    data_transferred,

    pub const json_field_names = .{
        .timeouts = "TIMEOUTS",
        .retransmissions = "RETRANSMISSIONS",
        .data_transferred = "DATA_TRANSFERRED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .timeouts => "TIMEOUTS",
            .retransmissions => "RETRANSMISSIONS",
            .data_transferred => "DATA_TRANSFERRED",
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
