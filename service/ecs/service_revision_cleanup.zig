const std = @import("std");

/// The time when Amazon ECS removes the source revisions' tasks relative to
/// deployment completion. When set to `BLOCKING`, Amazon ECS removes the
/// previous tasks before completing the deployment. When set to `DEFERRED`,
/// Amazon ECS completes the deployment first and removes the previous tasks in
/// the background.
pub const ServiceRevisionCleanup = enum {
    blocking,
    deferred,

    pub const json_field_names = .{
        .blocking = "BLOCKING",
        .deferred = "DEFERRED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .blocking => "BLOCKING",
            .deferred => "DEFERRED",
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
