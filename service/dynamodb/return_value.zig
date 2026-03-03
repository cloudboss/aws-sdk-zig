const std = @import("std");

pub const ReturnValue = enum {
    none,
    all_old,
    updated_old,
    all_new,
    updated_new,

    pub const json_field_names = .{
        .none = "NONE",
        .all_old = "ALL_OLD",
        .updated_old = "UPDATED_OLD",
        .all_new = "ALL_NEW",
        .updated_new = "UPDATED_NEW",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .all_old => "ALL_OLD",
            .updated_old => "UPDATED_OLD",
            .all_new => "ALL_NEW",
            .updated_new => "UPDATED_NEW",
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
