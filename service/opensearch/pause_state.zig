const std = @import("std");

/// The state of the automated snapshot pause. Valid values are `Active`,
/// `Completed`, `Scheduled`, and `Disabled`.
pub const PauseState = enum {
    active,
    completed,
    scheduled,
    disabled,

    pub const json_field_names = .{
        .active = "Active",
        .completed = "Completed",
        .scheduled = "Scheduled",
        .disabled = "Disabled",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .active => "Active",
            .completed => "Completed",
            .scheduled => "Scheduled",
            .disabled => "Disabled",
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
