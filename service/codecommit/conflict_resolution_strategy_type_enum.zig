const std = @import("std");

pub const ConflictResolutionStrategyTypeEnum = enum {
    none,
    accept_source,
    accept_destination,
    automerge,

    pub const json_field_names = .{
        .none = "NONE",
        .accept_source = "ACCEPT_SOURCE",
        .accept_destination = "ACCEPT_DESTINATION",
        .automerge = "AUTOMERGE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .accept_source => "ACCEPT_SOURCE",
            .accept_destination => "ACCEPT_DESTINATION",
            .automerge => "AUTOMERGE",
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
