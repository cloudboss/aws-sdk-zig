const std = @import("std");

/// Placeholder documentation for InputState
pub const InputState = enum {
    creating,
    detached,
    attached,
    deleting,
    deleted,

    pub const json_field_names = .{
        .creating = "CREATING",
        .detached = "DETACHED",
        .attached = "ATTACHED",
        .deleting = "DELETING",
        .deleted = "DELETED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .detached => "DETACHED",
            .attached => "ATTACHED",
            .deleting => "DELETING",
            .deleted => "DELETED",
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
