const std = @import("std");

pub const ContainerServiceState = enum {
    pending,
    ready,
    running,
    updating,
    deleting,
    disabled,
    deploying,

    pub const json_field_names = .{
        .pending = "PENDING",
        .ready = "READY",
        .running = "RUNNING",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .disabled = "DISABLED",
        .deploying = "DEPLOYING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .ready => "READY",
            .running => "RUNNING",
            .updating => "UPDATING",
            .deleting => "DELETING",
            .disabled => "DISABLED",
            .deploying => "DEPLOYING",
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
