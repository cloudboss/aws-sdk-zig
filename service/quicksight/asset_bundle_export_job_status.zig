const std = @import("std");

pub const AssetBundleExportJobStatus = enum {
    queued_for_immediate_execution,
    in_progress,
    successful,
    failed,

    pub const json_field_names = .{
        .queued_for_immediate_execution = "QUEUED_FOR_IMMEDIATE_EXECUTION",
        .in_progress = "IN_PROGRESS",
        .successful = "SUCCESSFUL",
        .failed = "FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .queued_for_immediate_execution => "QUEUED_FOR_IMMEDIATE_EXECUTION",
            .in_progress => "IN_PROGRESS",
            .successful => "SUCCESSFUL",
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
