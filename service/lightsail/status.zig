const std = @import("std");

pub const Status = enum {
    start_expired,
    not_started,
    started,
    starting,
    stopped,
    stopping,
    setting_up_instance,
    failed_instance_creation,
    failed_starting_gui_session,
    failed_stopping_gui_session,

    pub const json_field_names = .{
        .start_expired = "startExpired",
        .not_started = "notStarted",
        .started = "started",
        .starting = "starting",
        .stopped = "stopped",
        .stopping = "stopping",
        .setting_up_instance = "settingUpInstance",
        .failed_instance_creation = "failedInstanceCreation",
        .failed_starting_gui_session = "failedStartingGUISession",
        .failed_stopping_gui_session = "failedStoppingGUISession",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .start_expired => "startExpired",
            .not_started => "notStarted",
            .started => "started",
            .starting => "starting",
            .stopped => "stopped",
            .stopping => "stopping",
            .setting_up_instance => "settingUpInstance",
            .failed_instance_creation => "failedInstanceCreation",
            .failed_starting_gui_session => "failedStartingGUISession",
            .failed_stopping_gui_session => "failedStoppingGUISession",
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
