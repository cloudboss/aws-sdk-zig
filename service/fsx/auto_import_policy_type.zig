const std = @import("std");

pub const AutoImportPolicyType = enum {
    none,
    new,
    new_changed,
    new_changed_deleted,

    pub const json_field_names = .{
        .none = "NONE",
        .new = "NEW",
        .new_changed = "NEW_CHANGED",
        .new_changed_deleted = "NEW_CHANGED_DELETED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .new => "NEW",
            .new_changed => "NEW_CHANGED",
            .new_changed_deleted => "NEW_CHANGED_DELETED",
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
