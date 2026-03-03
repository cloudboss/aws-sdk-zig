const std = @import("std");

pub const LifecycleExecutionResourceActionName = enum {
    available,
    delete,
    deprecate,
    disable,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .delete = "DELETE",
        .deprecate = "DEPRECATE",
        .disable = "DISABLE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .available => "AVAILABLE",
            .delete => "DELETE",
            .deprecate => "DEPRECATE",
            .disable => "DISABLE",
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
