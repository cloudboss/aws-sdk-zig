const std = @import("std");

/// The key of a preference that can be configured on an agent space. The
/// `elevatedActionsEnabled` key controls whether elevated directed actions are
/// permitted in the agent space. Elevated directed actions are mutating
/// operations that also require per-action operator approval, and default to
/// `false` when not set.
pub const AgentSpacePreferenceKey = enum {
    elevated_actions_enabled,

    pub const json_field_names = .{
        .elevated_actions_enabled = "elevatedActionsEnabled",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .elevated_actions_enabled => "elevatedActionsEnabled",
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
