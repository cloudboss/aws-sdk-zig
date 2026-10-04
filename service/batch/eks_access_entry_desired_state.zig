const std = @import("std");

/// The desired state for the Batch-managed Amazon EKS access entry on a compute
/// environment.
pub const EksAccessEntryDesiredState = enum {
    enabled,
    disabled,
    inherit_from_cluster,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
        .inherit_from_cluster = "INHERIT_FROM_CLUSTER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .enabled => "ENABLED",
            .disabled => "DISABLED",
            .inherit_from_cluster => "INHERIT_FROM_CLUSTER",
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
