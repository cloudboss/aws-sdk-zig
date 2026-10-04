const std = @import("std");

/// The status of the most recent update to an endpoint. Possible values:
/// `InProgress` (update is in progress), `Successful` (update completed
/// successfully), `Failed` (update failed).
pub const EndpointUpdateStatus = enum {
    in_progress,
    successful,
    failed,

    pub const json_field_names = .{
        .in_progress = "InProgress",
        .successful = "Successful",
        .failed = "Failed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .in_progress => "InProgress",
            .successful => "Successful",
            .failed => "Failed",
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
