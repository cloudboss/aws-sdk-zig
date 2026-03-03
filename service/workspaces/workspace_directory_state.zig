const std = @import("std");

pub const WorkspaceDirectoryState = enum {
    registering,
    registered,
    deregistering,
    deregistered,
    @"error",

    pub const json_field_names = .{
        .registering = "REGISTERING",
        .registered = "REGISTERED",
        .deregistering = "DEREGISTERING",
        .deregistered = "DEREGISTERED",
        .@"error" = "ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .registering => "REGISTERING",
            .registered => "REGISTERED",
            .deregistering => "DEREGISTERING",
            .deregistered => "DEREGISTERED",
            .@"error" => "ERROR",
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
