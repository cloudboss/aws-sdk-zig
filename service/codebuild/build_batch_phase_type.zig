const std = @import("std");

pub const BuildBatchPhaseType = enum {
    submitted,
    download_batchspec,
    in_progress,
    combine_artifacts,
    succeeded,
    failed,
    stopped,

    pub const json_field_names = .{
        .submitted = "SUBMITTED",
        .download_batchspec = "DOWNLOAD_BATCHSPEC",
        .in_progress = "IN_PROGRESS",
        .combine_artifacts = "COMBINE_ARTIFACTS",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .stopped = "STOPPED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .submitted => "SUBMITTED",
            .download_batchspec => "DOWNLOAD_BATCHSPEC",
            .in_progress => "IN_PROGRESS",
            .combine_artifacts => "COMBINE_ARTIFACTS",
            .succeeded => "SUCCEEDED",
            .failed => "FAILED",
            .stopped => "STOPPED",
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
