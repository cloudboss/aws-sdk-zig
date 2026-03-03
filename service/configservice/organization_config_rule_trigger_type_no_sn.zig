const std = @import("std");

pub const OrganizationConfigRuleTriggerTypeNoSN = enum {
    configuration_item_change_notification,
    oversized_configuration_item_change_notifcation,

    pub const json_field_names = .{
        .configuration_item_change_notification = "ConfigurationItemChangeNotification",
        .oversized_configuration_item_change_notifcation = "OversizedConfigurationItemChangeNotification",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .configuration_item_change_notification => "ConfigurationItemChangeNotification",
            .oversized_configuration_item_change_notifcation => "OversizedConfigurationItemChangeNotification",
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
