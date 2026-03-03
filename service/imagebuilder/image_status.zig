const std = @import("std");

pub const ImageStatus = enum {
    pending,
    creating,
    building,
    testing,
    distributing,
    integrating,
    available,
    cancelled,
    failed,
    deprecated,
    deleted,
    disabled,

    pub const json_field_names = .{
        .pending = "PENDING",
        .creating = "CREATING",
        .building = "BUILDING",
        .testing = "TESTING",
        .distributing = "DISTRIBUTING",
        .integrating = "INTEGRATING",
        .available = "AVAILABLE",
        .cancelled = "CANCELLED",
        .failed = "FAILED",
        .deprecated = "DEPRECATED",
        .deleted = "DELETED",
        .disabled = "DISABLED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .creating => "CREATING",
            .building => "BUILDING",
            .testing => "TESTING",
            .distributing => "DISTRIBUTING",
            .integrating => "INTEGRATING",
            .available => "AVAILABLE",
            .cancelled => "CANCELLED",
            .failed => "FAILED",
            .deprecated => "DEPRECATED",
            .deleted => "DELETED",
            .disabled => "DISABLED",
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
