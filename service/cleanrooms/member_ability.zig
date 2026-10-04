const std = @import("std");

pub const MemberAbility = enum {
    can_query,
    can_receive_results,
    can_run_job,
    can_export_query_analysis_log,

    pub const json_field_names = .{
        .can_query = "CAN_QUERY",
        .can_receive_results = "CAN_RECEIVE_RESULTS",
        .can_run_job = "CAN_RUN_JOB",
        .can_export_query_analysis_log = "CAN_EXPORT_QUERY_ANALYSIS_LOG",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .can_query => "CAN_QUERY",
            .can_receive_results => "CAN_RECEIVE_RESULTS",
            .can_run_job => "CAN_RUN_JOB",
            .can_export_query_analysis_log => "CAN_EXPORT_QUERY_ANALYSIS_LOG",
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
