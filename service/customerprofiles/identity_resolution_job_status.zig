const std = @import("std");

pub const IdentityResolutionJobStatus = enum {
    pending,
    preprocessing,
    find_matching,
    merging,
    completed,
    partial_success,
    failed,

    pub const json_field_names = .{
        .pending = "PENDING",
        .preprocessing = "PREPROCESSING",
        .find_matching = "FIND_MATCHING",
        .merging = "MERGING",
        .completed = "COMPLETED",
        .partial_success = "PARTIAL_SUCCESS",
        .failed = "FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .preprocessing => "PREPROCESSING",
            .find_matching => "FIND_MATCHING",
            .merging => "MERGING",
            .completed => "COMPLETED",
            .partial_success => "PARTIAL_SUCCESS",
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
