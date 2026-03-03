const std = @import("std");

pub const RecoveryResult = enum {
    not_started,
    in_progress,
    success,
    fail,
    partial_success,
    associate_success,
    associate_fail,

    pub const json_field_names = .{
        .not_started = "NOT_STARTED",
        .in_progress = "IN_PROGRESS",
        .success = "SUCCESS",
        .fail = "FAIL",
        .partial_success = "PARTIAL_SUCCESS",
        .associate_success = "ASSOCIATE_SUCCESS",
        .associate_fail = "ASSOCIATE_FAIL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .not_started => "NOT_STARTED",
            .in_progress => "IN_PROGRESS",
            .success => "SUCCESS",
            .fail => "FAIL",
            .partial_success => "PARTIAL_SUCCESS",
            .associate_success => "ASSOCIATE_SUCCESS",
            .associate_fail => "ASSOCIATE_FAIL",
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
