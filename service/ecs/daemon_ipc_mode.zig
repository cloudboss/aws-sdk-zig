const std = @import("std");

pub const DaemonIpcMode = enum {
    /// The daemon gets its own isolated IPC namespace.
    none,
    /// The daemon shares the IPC namespace with co-located tasks on the same
    /// container instance.
    shared,

    pub const json_field_names = .{
        .none = "none",
        .shared = "shared",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "none",
            .shared => "shared",
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
