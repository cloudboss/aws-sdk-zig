const std = @import("std");

pub const ContactStatus = enum {
    scheduling,
    failed_to_schedule,
    scheduled,
    cancelled,
    aws_cancelled,
    prepass,
    pass,
    postpass,
    completed,
    failed,
    available,
    cancelling,
    aws_failed,

    pub const json_field_names = .{
        .scheduling = "SCHEDULING",
        .failed_to_schedule = "FAILED_TO_SCHEDULE",
        .scheduled = "SCHEDULED",
        .cancelled = "CANCELLED",
        .aws_cancelled = "AWS_CANCELLED",
        .prepass = "PREPASS",
        .pass = "PASS",
        .postpass = "POSTPASS",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .available = "AVAILABLE",
        .cancelling = "CANCELLING",
        .aws_failed = "AWS_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .scheduling => "SCHEDULING",
            .failed_to_schedule => "FAILED_TO_SCHEDULE",
            .scheduled => "SCHEDULED",
            .cancelled => "CANCELLED",
            .aws_cancelled => "AWS_CANCELLED",
            .prepass => "PREPASS",
            .pass => "PASS",
            .postpass => "POSTPASS",
            .completed => "COMPLETED",
            .failed => "FAILED",
            .available => "AVAILABLE",
            .cancelling => "CANCELLING",
            .aws_failed => "AWS_FAILED",
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
