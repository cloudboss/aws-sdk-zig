const std = @import("std");

pub const OnClusterAppUIType = enum {
    spark_history_server,
    yarn_timeline_service,
    tez_ui,
    application_master,
    job_history_server,
    resource_manager,

    pub const json_field_names = .{
        .spark_history_server = "SparkHistoryServer",
        .yarn_timeline_service = "YarnTimelineService",
        .tez_ui = "TezUI",
        .application_master = "ApplicationMaster",
        .job_history_server = "JobHistoryServer",
        .resource_manager = "ResourceManager",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .spark_history_server => "SparkHistoryServer",
            .yarn_timeline_service => "YarnTimelineService",
            .tez_ui => "TezUI",
            .application_master => "ApplicationMaster",
            .job_history_server => "JobHistoryServer",
            .resource_manager => "ResourceManager",
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
