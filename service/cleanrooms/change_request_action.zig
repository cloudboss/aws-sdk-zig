const std = @import("std");

pub const ChangeRequestAction = enum {
    approve,
    deny,
    cancel,
    commit,

    pub const json_field_names = .{
        .approve = "APPROVE",
        .deny = "DENY",
        .cancel = "CANCEL",
        .commit = "COMMIT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .approve => "APPROVE",
            .deny => "DENY",
            .cancel => "CANCEL",
            .commit => "COMMIT",
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
