const std = @import("std");

pub const AgentCollaboration = enum {
    supervisor,
    supervisor_router,
    disabled,

    pub const json_field_names = .{
        .supervisor = "SUPERVISOR",
        .supervisor_router = "SUPERVISOR_ROUTER",
        .disabled = "DISABLED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .supervisor => "SUPERVISOR",
            .supervisor_router => "SUPERVISOR_ROUTER",
            .disabled => "DISABLED",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
