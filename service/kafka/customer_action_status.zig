const std = @import("std");

/// A type of an action required from the customer.
pub const CustomerActionStatus = enum {
    critical_action_required,
    action_recommended,
    none,

    pub const json_field_names = .{
        .critical_action_required = "CRITICAL_ACTION_REQUIRED",
        .action_recommended = "ACTION_RECOMMENDED",
        .none = "NONE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .critical_action_required => "CRITICAL_ACTION_REQUIRED",
            .action_recommended => "ACTION_RECOMMENDED",
            .none => "NONE",
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
