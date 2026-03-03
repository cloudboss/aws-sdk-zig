const std = @import("std");

pub const EnvironmentStatus = enum {
    aborting,
    launching,
    updating,
    linking_from,
    linking_to,
    ready,
    terminating,
    terminated,

    pub const json_field_names = .{
        .aborting = "Aborting",
        .launching = "Launching",
        .updating = "Updating",
        .linking_from = "LinkingFrom",
        .linking_to = "LinkingTo",
        .ready = "Ready",
        .terminating = "Terminating",
        .terminated = "Terminated",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aborting => "Aborting",
            .launching => "Launching",
            .updating => "Updating",
            .linking_from => "LinkingFrom",
            .linking_to => "LinkingTo",
            .ready => "Ready",
            .terminating => "Terminating",
            .terminated => "Terminated",
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
