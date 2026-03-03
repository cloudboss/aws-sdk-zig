const std = @import("std");

pub const ClosureCode = enum {
    investigation_completed,
    not_resolved,
    false_positive,
    duplicate,

    pub const json_field_names = .{
        .investigation_completed = "Investigation Completed",
        .not_resolved = "Not Resolved",
        .false_positive = "False Positive",
        .duplicate = "Duplicate",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .investigation_completed => "Investigation Completed",
            .not_resolved => "Not Resolved",
            .false_positive => "False Positive",
            .duplicate => "Duplicate",
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
