const std = @import("std");

pub const HistoryItemType = enum {
    configuration_update,
    state_update,
    action,
    alarm_contributor_state_update,
    alarm_contributor_action,

    pub const json_field_names = .{
        .configuration_update = "ConfigurationUpdate",
        .state_update = "StateUpdate",
        .action = "Action",
        .alarm_contributor_state_update = "AlarmContributorStateUpdate",
        .alarm_contributor_action = "AlarmContributorAction",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .configuration_update => "ConfigurationUpdate",
            .state_update => "StateUpdate",
            .action => "Action",
            .alarm_contributor_state_update => "AlarmContributorStateUpdate",
            .alarm_contributor_action => "AlarmContributorAction",
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
