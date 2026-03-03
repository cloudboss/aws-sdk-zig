const std = @import("std");

pub const RetentionAction = enum {
    none,
    delete,
    permanently_delete,

    pub const json_field_names = .{
        .none = "NONE",
        .delete = "DELETE",
        .permanently_delete = "PERMANENTLY_DELETE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .delete => "DELETE",
            .permanently_delete => "PERMANENTLY_DELETE",
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
