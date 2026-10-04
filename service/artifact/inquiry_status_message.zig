const std = @import("std");

pub const InquiryStatusMessage = enum {
    success,
    malware_detected_error,
    in_progress,
    internal_error,
    human_review_in_progress,
    completed_with_errors,

    pub const json_field_names = .{
        .success = "Compliance inquiry processing is complete.",
        .malware_detected_error = "Malware was detected on the file. Provide a new file and try again.",
        .in_progress = "Compliance inquiry processing is in-progress.",
        .internal_error = "An internal error occurred while processing the inquiry. Try again at a later time.",
        .human_review_in_progress = "Human review is in progress.",
        .completed_with_errors = "Compliance inquiry processing is complete. One or more queries encountered errors during processing.",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .success => "Compliance inquiry processing is complete.",
            .malware_detected_error => "Malware was detected on the file. Provide a new file and try again.",
            .in_progress => "Compliance inquiry processing is in-progress.",
            .internal_error => "An internal error occurred while processing the inquiry. Try again at a later time.",
            .human_review_in_progress => "Human review is in progress.",
            .completed_with_errors => "Compliance inquiry processing is complete. One or more queries encountered errors during processing.",
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
