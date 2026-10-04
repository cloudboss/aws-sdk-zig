const std = @import("std");

pub const SchemaStatus = enum {
    processing,
    active,
    deleting,
    failed,
    success,
    not_applicable,

    pub const json_field_names = .{
        .processing = "PROCESSING",
        .active = "ACTIVE",
        .deleting = "DELETING",
        .failed = "FAILED",
        .success = "SUCCESS",
        .not_applicable = "NOT_APPLICABLE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .processing => "PROCESSING",
            .active => "ACTIVE",
            .deleting => "DELETING",
            .failed => "FAILED",
            .success => "SUCCESS",
            .not_applicable => "NOT_APPLICABLE",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
