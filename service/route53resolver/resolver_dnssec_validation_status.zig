const std = @import("std");

pub const ResolverDNSSECValidationStatus = enum {
    enabling,
    enabled,
    disabling,
    disabled,
    update_to_use_local_resource_setting,
    use_local_resource_setting,

    pub const json_field_names = .{
        .enabling = "ENABLING",
        .enabled = "ENABLED",
        .disabling = "DISABLING",
        .disabled = "DISABLED",
        .update_to_use_local_resource_setting = "UPDATING_TO_USE_LOCAL_RESOURCE_SETTING",
        .use_local_resource_setting = "USE_LOCAL_RESOURCE_SETTING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .enabling => "ENABLING",
            .enabled => "ENABLED",
            .disabling => "DISABLING",
            .disabled => "DISABLED",
            .update_to_use_local_resource_setting => "UPDATING_TO_USE_LOCAL_RESOURCE_SETTING",
            .use_local_resource_setting => "USE_LOCAL_RESOURCE_SETTING",
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
