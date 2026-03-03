const std = @import("std");

pub const TestSetStatus = enum {
    importing,
    pending_annotation,
    deleting,
    validation_error,
    ready,

    pub const json_field_names = .{
        .importing = "Importing",
        .pending_annotation = "PendingAnnotation",
        .deleting = "Deleting",
        .validation_error = "ValidationError",
        .ready = "Ready",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .importing => "Importing",
            .pending_annotation => "PendingAnnotation",
            .deleting => "Deleting",
            .validation_error => "ValidationError",
            .ready => "Ready",
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
