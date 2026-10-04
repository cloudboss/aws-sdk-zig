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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
