const std = @import("std");

pub const AuditCheckRunStatus = enum {
    in_progress,
    waiting_for_data_collection,
    canceled,
    completed_compliant,
    completed_non_compliant,
    failed,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .waiting_for_data_collection = "WAITING_FOR_DATA_COLLECTION",
        .canceled = "CANCELED",
        .completed_compliant = "COMPLETED_COMPLIANT",
        .completed_non_compliant = "COMPLETED_NON_COMPLIANT",
        .failed = "FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .in_progress => "IN_PROGRESS",
            .waiting_for_data_collection => "WAITING_FOR_DATA_COLLECTION",
            .canceled => "CANCELED",
            .completed_compliant => "COMPLETED_COMPLIANT",
            .completed_non_compliant => "COMPLETED_NON_COMPLIANT",
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
