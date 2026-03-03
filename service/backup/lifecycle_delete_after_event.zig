const std = @import("std");

pub const LifecycleDeleteAfterEvent = enum {
    delete_after_copy,

    pub const json_field_names = .{
        .delete_after_copy = "DELETE_AFTER_COPY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .delete_after_copy => "DELETE_AFTER_COPY",
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
