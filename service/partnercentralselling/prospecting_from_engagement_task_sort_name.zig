const std = @import("std");

/// The fields available for sorting results from
/// `ListProspectingFromEngagementTasks`. Valid values are `StartTime`,
/// `TaskName`, and `FailedEngagementCount`.
pub const ProspectingFromEngagementTaskSortName = enum {
    start_time,
    task_name,
    failed_engagement_count,

    pub const json_field_names = .{
        .start_time = "StartTime",
        .task_name = "TaskName",
        .failed_engagement_count = "FailedEngagementCount",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .start_time => "StartTime",
            .task_name => "TaskName",
            .failed_engagement_count => "FailedEngagementCount",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
