const std = @import("std");

/// The status of a ForEach step execution. Valid values are:
///
/// * `Succeeded` indicates that the ForEach step execution completed
///   successfully.
/// * `Failed` indicates that the ForEach step execution failed.
/// * `Stopped` indicates that the ForEach step execution was stopped.
pub const ForEachStatus = enum {
    succeeded,
    failed,
    stopped,

    pub const json_field_names = .{
        .succeeded = "Succeeded",
        .failed = "Failed",
        .stopped = "Stopped",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .succeeded => "Succeeded",
            .failed => "Failed",
            .stopped => "Stopped",
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
