const std = @import("std");

pub const AssessmentRunState = enum {
    created,
    start_data_collection_pending,
    start_data_collection_in_progress,
    collecting_data,
    stop_data_collection_pending,
    data_collected,
    start_evaluating_rules_pending,
    evaluating_rules,
    failed,
    @"error",
    completed,
    completed_with_errors,
    canceled,

    pub const json_field_names = .{
        .created = "CREATED",
        .start_data_collection_pending = "START_DATA_COLLECTION_PENDING",
        .start_data_collection_in_progress = "START_DATA_COLLECTION_IN_PROGRESS",
        .collecting_data = "COLLECTING_DATA",
        .stop_data_collection_pending = "STOP_DATA_COLLECTION_PENDING",
        .data_collected = "DATA_COLLECTED",
        .start_evaluating_rules_pending = "START_EVALUATING_RULES_PENDING",
        .evaluating_rules = "EVALUATING_RULES",
        .failed = "FAILED",
        .@"error" = "ERROR",
        .completed = "COMPLETED",
        .completed_with_errors = "COMPLETED_WITH_ERRORS",
        .canceled = "CANCELED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .created => "CREATED",
            .start_data_collection_pending => "START_DATA_COLLECTION_PENDING",
            .start_data_collection_in_progress => "START_DATA_COLLECTION_IN_PROGRESS",
            .collecting_data => "COLLECTING_DATA",
            .stop_data_collection_pending => "STOP_DATA_COLLECTION_PENDING",
            .data_collected => "DATA_COLLECTED",
            .start_evaluating_rules_pending => "START_EVALUATING_RULES_PENDING",
            .evaluating_rules => "EVALUATING_RULES",
            .failed => "FAILED",
            .@"error" => "ERROR",
            .completed => "COMPLETED",
            .completed_with_errors => "COMPLETED_WITH_ERRORS",
            .canceled => "CANCELED",
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
