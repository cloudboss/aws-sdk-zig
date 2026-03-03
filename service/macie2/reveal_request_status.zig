const std = @import("std");

/// The status of a request to retrieve occurrences of sensitive data reported
/// by a finding. Possible values are:
pub const RevealRequestStatus = enum {
    success,
    processing,
    @"error",

    pub const json_field_names = .{
        .success = "SUCCESS",
        .processing = "PROCESSING",
        .@"error" = "ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .success => "SUCCESS",
            .processing => "PROCESSING",
            .@"error" => "ERROR",
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
