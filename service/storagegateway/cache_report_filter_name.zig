const std = @import("std");

pub const CacheReportFilterName = enum {
    upload_state,
    upload_failure_reason,

    pub const json_field_names = .{
        .upload_state = "UploadState",
        .upload_failure_reason = "UploadFailureReason",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .upload_state => "UploadState",
            .upload_failure_reason => "UploadFailureReason",
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
