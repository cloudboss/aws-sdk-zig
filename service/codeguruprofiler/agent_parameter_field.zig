const std = @import("std");

pub const AgentParameterField = enum {
    /// Sampling interval in milliseconds used to sample profiles.
    sampling_interval_in_milliseconds,
    /// Reporting interval in milliseconds used to report profiles.
    reporting_interval_in_milliseconds,
    /// Minimum time in milliseconds between sending reports.
    minimum_time_for_reporting_in_milliseconds,
    /// Percentage of memory to be used by CodeGuru profiler. Minimum of 30MB is
    /// required for the agent.
    memory_usage_limit_percent,
    /// Maximum stack depth to be captured by the CodeGuru Profiler.
    max_stack_depth,

    pub const json_field_names = .{
        .sampling_interval_in_milliseconds = "SamplingIntervalInMilliseconds",
        .reporting_interval_in_milliseconds = "ReportingIntervalInMilliseconds",
        .minimum_time_for_reporting_in_milliseconds = "MinimumTimeForReportingInMilliseconds",
        .memory_usage_limit_percent = "MemoryUsageLimitPercent",
        .max_stack_depth = "MaxStackDepth",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sampling_interval_in_milliseconds => "SamplingIntervalInMilliseconds",
            .reporting_interval_in_milliseconds => "ReportingIntervalInMilliseconds",
            .minimum_time_for_reporting_in_milliseconds => "MinimumTimeForReportingInMilliseconds",
            .memory_usage_limit_percent => "MemoryUsageLimitPercent",
            .max_stack_depth => "MaxStackDepth",
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
