const std = @import("std");

pub const InquiryStatus = enum {
    processing,
    human_review,
    completed,
    failed,

    pub const json_field_names = .{
        .processing = "PROCESSING",
        .human_review = "HUMAN_REVIEW",
        .completed = "COMPLETED",
        .failed = "FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .processing => "PROCESSING",
            .human_review => "HUMAN_REVIEW",
            .completed => "COMPLETED",
            .failed => "FAILED",
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
