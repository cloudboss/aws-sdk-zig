const std = @import("std");

/// Specifies whether to automatically enable automated sensitive data discovery
/// for accounts that are part of an organization in Amazon Macie. Valid values
/// are:
pub const AutoEnableMode = enum {
    all,
    new,
    none,

    pub const json_field_names = .{
        .all = "ALL",
        .new = "NEW",
        .none = "NONE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .all => "ALL",
            .new => "NEW",
            .none => "NONE",
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
