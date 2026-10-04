const std = @import("std");

pub const ImageState = enum {
    pending,
    available,
    failed,
    copying,
    deleting,
    creating,
    importing,
    validating,

    pub const json_field_names = .{
        .pending = "PENDING",
        .available = "AVAILABLE",
        .failed = "FAILED",
        .copying = "COPYING",
        .deleting = "DELETING",
        .creating = "CREATING",
        .importing = "IMPORTING",
        .validating = "VALIDATING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .available => "AVAILABLE",
            .failed => "FAILED",
            .copying => "COPYING",
            .deleting => "DELETING",
            .creating => "CREATING",
            .importing => "IMPORTING",
            .validating => "VALIDATING",
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
