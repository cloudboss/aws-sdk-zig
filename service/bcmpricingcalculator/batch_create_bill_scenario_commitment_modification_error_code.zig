const std = @import("std");

pub const BatchCreateBillScenarioCommitmentModificationErrorCode = enum {
    conflict,
    internal_server_error,
    invalid_account,

    pub const json_field_names = .{
        .conflict = "CONFLICT",
        .internal_server_error = "INTERNAL_SERVER_ERROR",
        .invalid_account = "INVALID_ACCOUNT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .conflict => "CONFLICT",
            .internal_server_error => "INTERNAL_SERVER_ERROR",
            .invalid_account => "INVALID_ACCOUNT",
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
