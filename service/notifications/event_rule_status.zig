const std = @import("std");

pub const EventRuleStatus = enum {
    /// EventRule is processing events. Any call can be executed.
    active,
    /// EventRule is in a bad state and may not be processing events. Any call can
    /// be executed.
    inactive,
    /// This EventRule is being created. Only GET/LIST calls can be executed.
    creating,
    /// This EventRule is being updated. Only GET/LIST calls can be executed.
    updating,
    /// This EventRule is being deleted. Only GET/LIST calls can be executed.
    deleting,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .inactive = "INACTIVE",
        .creating = "CREATING",
        .updating = "UPDATING",
        .deleting = "DELETING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .active => "ACTIVE",
            .inactive => "INACTIVE",
            .creating => "CREATING",
            .updating => "UPDATING",
            .deleting => "DELETING",
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
