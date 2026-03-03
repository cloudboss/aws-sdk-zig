const std = @import("std");

/// Input Loss Action For Udp Out
pub const InputLossActionForUdpOut = enum {
    drop_program,
    drop_ts,
    emit_program,

    pub const json_field_names = .{
        .drop_program = "DROP_PROGRAM",
        .drop_ts = "DROP_TS",
        .emit_program = "EMIT_PROGRAM",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .drop_program => "DROP_PROGRAM",
            .drop_ts => "DROP_TS",
            .emit_program => "EMIT_PROGRAM",
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
