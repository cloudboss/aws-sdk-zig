const std = @import("std");

pub const PolicyAction = enum {
    delete,
    retain,
    snapshot,
    replace_and_delete,
    replace_and_retain,
    replace_and_snapshot,

    pub const json_field_names = .{
        .delete = "Delete",
        .retain = "Retain",
        .snapshot = "Snapshot",
        .replace_and_delete = "ReplaceAndDelete",
        .replace_and_retain = "ReplaceAndRetain",
        .replace_and_snapshot = "ReplaceAndSnapshot",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .delete => "Delete",
            .retain => "Retain",
            .snapshot => "Snapshot",
            .replace_and_delete => "ReplaceAndDelete",
            .replace_and_retain => "ReplaceAndRetain",
            .replace_and_snapshot => "ReplaceAndSnapshot",
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
