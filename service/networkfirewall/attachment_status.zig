const std = @import("std");

pub const AttachmentStatus = enum {
    creating,
    deleting,
    failed,
    @"error",
    scaling,
    ready,

    pub const json_field_names = .{
        .creating = "CREATING",
        .deleting = "DELETING",
        .failed = "FAILED",
        .@"error" = "ERROR",
        .scaling = "SCALING",
        .ready = "READY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .deleting => "DELETING",
            .failed => "FAILED",
            .@"error" => "ERROR",
            .scaling => "SCALING",
            .ready => "READY",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
