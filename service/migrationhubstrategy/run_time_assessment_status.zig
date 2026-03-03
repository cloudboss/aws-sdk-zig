const std = @import("std");

pub const RunTimeAssessmentStatus = enum {
    dc_to_be_scheduled,
    dc_req_sent,
    dc_started,
    dc_stopped,
    dc_success,
    dc_failed,
    dc_partial_success,

    pub const json_field_names = .{
        .dc_to_be_scheduled = "dataCollectionTaskToBeScheduled",
        .dc_req_sent = "dataCollectionTaskScheduled",
        .dc_started = "dataCollectionTaskStarted",
        .dc_stopped = "dataCollectionTaskStopped",
        .dc_success = "dataCollectionTaskSuccess",
        .dc_failed = "dataCollectionTaskFailed",
        .dc_partial_success = "dataCollectionTaskPartialSuccess",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .dc_to_be_scheduled => "dataCollectionTaskToBeScheduled",
            .dc_req_sent => "dataCollectionTaskScheduled",
            .dc_started => "dataCollectionTaskStarted",
            .dc_stopped => "dataCollectionTaskStopped",
            .dc_success => "dataCollectionTaskSuccess",
            .dc_failed => "dataCollectionTaskFailed",
            .dc_partial_success => "dataCollectionTaskPartialSuccess",
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
