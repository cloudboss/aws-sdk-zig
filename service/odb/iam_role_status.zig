const std = @import("std");

pub const IamRoleStatus = enum {
    associating,
    disassociating,
    failed,
    connected,
    disconnected,
    partially_connected,
    unknown,

    pub const json_field_names = .{
        .associating = "ASSOCIATING",
        .disassociating = "DISASSOCIATING",
        .failed = "FAILED",
        .connected = "CONNECTED",
        .disconnected = "DISCONNECTED",
        .partially_connected = "PARTIALLY_CONNECTED",
        .unknown = "UNKNOWN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .associating => "ASSOCIATING",
            .disassociating => "DISASSOCIATING",
            .failed => "FAILED",
            .connected => "CONNECTED",
            .disconnected => "DISCONNECTED",
            .partially_connected => "PARTIALLY_CONNECTED",
            .unknown => "UNKNOWN",
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
