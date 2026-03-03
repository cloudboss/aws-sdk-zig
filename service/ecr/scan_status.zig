const std = @import("std");

pub const ScanStatus = enum {
    in_progress,
    complete,
    failed,
    unsupported_image,
    active,
    pending,
    scan_eligibility_expired,
    findings_unavailable,
    limit_exceeded,
    image_archived,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .complete = "COMPLETE",
        .failed = "FAILED",
        .unsupported_image = "UNSUPPORTED_IMAGE",
        .active = "ACTIVE",
        .pending = "PENDING",
        .scan_eligibility_expired = "SCAN_ELIGIBILITY_EXPIRED",
        .findings_unavailable = "FINDINGS_UNAVAILABLE",
        .limit_exceeded = "LIMIT_EXCEEDED",
        .image_archived = "IMAGE_ARCHIVED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .in_progress => "IN_PROGRESS",
            .complete => "COMPLETE",
            .failed => "FAILED",
            .unsupported_image => "UNSUPPORTED_IMAGE",
            .active => "ACTIVE",
            .pending => "PENDING",
            .scan_eligibility_expired => "SCAN_ELIGIBILITY_EXPIRED",
            .findings_unavailable => "FINDINGS_UNAVAILABLE",
            .limit_exceeded => "LIMIT_EXCEEDED",
            .image_archived => "IMAGE_ARCHIVED",
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
