const std = @import("std");

pub const ResolverEndpointStatus = enum {
    creating,
    operational,
    updating,
    auto_recovering,
    action_needed,
    deleting,

    pub const json_field_names = .{
        .creating = "CREATING",
        .operational = "OPERATIONAL",
        .updating = "UPDATING",
        .auto_recovering = "AUTO_RECOVERING",
        .action_needed = "ACTION_NEEDED",
        .deleting = "DELETING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .operational => "OPERATIONAL",
            .updating => "UPDATING",
            .auto_recovering => "AUTO_RECOVERING",
            .action_needed => "ACTION_NEEDED",
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
