const std = @import("std");

pub const BatchDeleteBillScenarioCommitmentModificationErrorCode = enum {
    bad_request,
    conflict,
    internal_server_error,

    pub const json_field_names = .{
        .bad_request = "BAD_REQUEST",
        .conflict = "CONFLICT",
        .internal_server_error = "INTERNAL_SERVER_ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .bad_request => "BAD_REQUEST",
            .conflict => "CONFLICT",
            .internal_server_error => "INTERNAL_SERVER_ERROR",
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
