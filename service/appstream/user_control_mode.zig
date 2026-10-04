const std = @import("std");

/// The user control mode for agent sessions.
///
/// * VIEW_ONLY - Users can view and observe agent actions as they happen.
///
/// * VIEW_STOP - Users can view agent actions and stop the agent if needed.
///
/// * DISABLED - Users cannot view or stop the agent session.
pub const UserControlMode = enum {
    view_only,
    view_stop,
    disabled,

    pub const json_field_names = .{
        .view_only = "VIEW_ONLY",
        .view_stop = "VIEW_STOP",
        .disabled = "DISABLED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .view_only => "VIEW_ONLY",
            .view_stop => "VIEW_STOP",
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
