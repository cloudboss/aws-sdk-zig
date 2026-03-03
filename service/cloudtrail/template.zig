const std = @import("std");

/// Specifies the type of the aggregation templates in the aggregation
/// configuration. Valid values include API_ACTIVITY, RESOURCE_ACCESS and
/// USER_ACTIONS.
pub const Template = enum {
    api_activity,
    resource_access,
    user_actions,

    pub const json_field_names = .{
        .api_activity = "API_ACTIVITY",
        .resource_access = "RESOURCE_ACCESS",
        .user_actions = "USER_ACTIONS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .api_activity => "API_ACTIVITY",
            .resource_access => "RESOURCE_ACCESS",
            .user_actions => "USER_ACTIONS",
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
