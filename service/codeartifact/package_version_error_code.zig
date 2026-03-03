const std = @import("std");

pub const PackageVersionErrorCode = enum {
    already_exists,
    mismatched_revision,
    mismatched_status,
    not_allowed,
    not_found,
    skipped,

    pub const json_field_names = .{
        .already_exists = "ALREADY_EXISTS",
        .mismatched_revision = "MISMATCHED_REVISION",
        .mismatched_status = "MISMATCHED_STATUS",
        .not_allowed = "NOT_ALLOWED",
        .not_found = "NOT_FOUND",
        .skipped = "SKIPPED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .already_exists => "ALREADY_EXISTS",
            .mismatched_revision => "MISMATCHED_REVISION",
            .mismatched_status => "MISMATCHED_STATUS",
            .not_allowed => "NOT_ALLOWED",
            .not_found => "NOT_FOUND",
            .skipped => "SKIPPED",
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
