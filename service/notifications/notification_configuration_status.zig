const std = @import("std");

pub const NotificationConfigurationStatus = enum {
    /// All of the EventRules are in ACTIVE Status. Any call can be executed.
    active,
    /// Some EventRules are in ACTIVE Status and some are INACTIVE. Any call can be
    /// executed.
    partially_active,
    /// All of the EventRules are in INACTIVE Status. Any call can be executed.
    inactive,
    /// This NotificationConfiguration is being deleted. Only GET/LIST calls can be
    /// executed.
    deleting,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .partially_active = "PARTIALLY_ACTIVE",
        .inactive = "INACTIVE",
        .deleting = "DELETING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .active => "ACTIVE",
            .partially_active => "PARTIALLY_ACTIVE",
            .inactive => "INACTIVE",
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
