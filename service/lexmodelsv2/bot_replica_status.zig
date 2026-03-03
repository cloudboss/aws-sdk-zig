const std = @import("std");

/// The status of the operation to replicate the bot. Values: Enabling, Enabled,
/// Deleting, Failed.
pub const BotReplicaStatus = enum {
    enabling,
    enabled,
    deleting,
    failed,

    pub const json_field_names = .{
        .enabling = "Enabling",
        .enabled = "Enabled",
        .deleting = "Deleting",
        .failed = "Failed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .enabling => "Enabling",
            .enabled => "Enabled",
            .deleting => "Deleting",
            .failed => "Failed",
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
