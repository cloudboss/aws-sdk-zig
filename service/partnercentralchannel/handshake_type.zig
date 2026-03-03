const std = @import("std");

pub const HandshakeType = enum {
    start_service_period,
    revoke_service_period,
    program_management_account,

    pub const json_field_names = .{
        .start_service_period = "START_SERVICE_PERIOD",
        .revoke_service_period = "REVOKE_SERVICE_PERIOD",
        .program_management_account = "PROGRAM_MANAGEMENT_ACCOUNT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .start_service_period => "START_SERVICE_PERIOD",
            .revoke_service_period => "REVOKE_SERVICE_PERIOD",
            .program_management_account => "PROGRAM_MANAGEMENT_ACCOUNT",
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
