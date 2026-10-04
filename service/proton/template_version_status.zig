const std = @import("std");

pub const TemplateVersionStatus = enum {
    registration_in_progress,
    registration_failed,
    draft,
    published,

    pub const json_field_names = .{
        .registration_in_progress = "REGISTRATION_IN_PROGRESS",
        .registration_failed = "REGISTRATION_FAILED",
        .draft = "DRAFT",
        .published = "PUBLISHED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .registration_in_progress => "REGISTRATION_IN_PROGRESS",
            .registration_failed => "REGISTRATION_FAILED",
            .draft => "DRAFT",
            .published => "PUBLISHED",
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
