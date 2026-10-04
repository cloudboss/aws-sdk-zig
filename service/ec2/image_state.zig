const std = @import("std");

pub const ImageState = enum {
    pending,
    available,
    invalid,
    deregistered,
    transient,
    failed,
    @"error",
    disabled,

    pub const json_field_names = .{
        .pending = "pending",
        .available = "available",
        .invalid = "invalid",
        .deregistered = "deregistered",
        .transient = "transient",
        .failed = "failed",
        .@"error" = "error",
        .disabled = "disabled",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "pending",
            .available => "available",
            .invalid => "invalid",
            .deregistered => "deregistered",
            .transient => "transient",
            .failed => "failed",
            .@"error" => "error",
            .disabled => "disabled",
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
