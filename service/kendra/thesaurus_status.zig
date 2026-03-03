const std = @import("std");

pub const ThesaurusStatus = enum {
    creating,
    active,
    deleting,
    updating,
    active_but_update_failed,
    failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .deleting = "DELETING",
        .updating = "UPDATING",
        .active_but_update_failed = "ACTIVE_BUT_UPDATE_FAILED",
        .failed = "FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .active => "ACTIVE",
            .deleting => "DELETING",
            .updating => "UPDATING",
            .active_but_update_failed => "ACTIVE_BUT_UPDATE_FAILED",
            .failed => "FAILED",
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
