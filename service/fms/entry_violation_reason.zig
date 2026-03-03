const std = @import("std");

pub const EntryViolationReason = enum {
    missing_expected_entry,
    incorrect_entry_order,
    entry_conflict,

    pub const json_field_names = .{
        .missing_expected_entry = "MISSING_EXPECTED_ENTRY",
        .incorrect_entry_order = "INCORRECT_ENTRY_ORDER",
        .entry_conflict = "ENTRY_CONFLICT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .missing_expected_entry => "MISSING_EXPECTED_ENTRY",
            .incorrect_entry_order => "INCORRECT_ENTRY_ORDER",
            .entry_conflict => "ENTRY_CONFLICT",
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
