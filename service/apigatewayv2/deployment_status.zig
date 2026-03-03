const std = @import("std");

/// Represents a deployment status.
pub const DeploymentStatus = enum {
    pending,
    failed,
    deployed,

    pub const json_field_names = .{
        .pending = "PENDING",
        .failed = "FAILED",
        .deployed = "DEPLOYED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .failed => "FAILED",
            .deployed => "DEPLOYED",
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
