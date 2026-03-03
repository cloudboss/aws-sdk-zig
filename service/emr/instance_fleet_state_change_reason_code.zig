const std = @import("std");

pub const InstanceFleetStateChangeReasonCode = enum {
    internal_error,
    validation_error,
    instance_failure,
    cluster_terminated,

    pub const json_field_names = .{
        .internal_error = "INTERNAL_ERROR",
        .validation_error = "VALIDATION_ERROR",
        .instance_failure = "INSTANCE_FAILURE",
        .cluster_terminated = "CLUSTER_TERMINATED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .internal_error => "INTERNAL_ERROR",
            .validation_error => "VALIDATION_ERROR",
            .instance_failure => "INSTANCE_FAILURE",
            .cluster_terminated => "CLUSTER_TERMINATED",
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
