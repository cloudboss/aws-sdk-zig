const std = @import("std");

/// List of status supported by optimization jobs
pub const BlueprintOptimizationJobStatus = enum {
    created,
    in_progress,
    success,
    service_error,
    client_error,

    pub const json_field_names = .{
        .created = "Created",
        .in_progress = "InProgress",
        .success = "Success",
        .service_error = "ServiceError",
        .client_error = "ClientError",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .created => "Created",
            .in_progress => "InProgress",
            .success => "Success",
            .service_error => "ServiceError",
            .client_error => "ClientError",
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
