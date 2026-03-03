const std = @import("std");

/// The type of replicated topic name.
pub const ReplicationTopicNameConfigurationType = enum {
    prefixed_with_source_cluster_alias,
    identical,

    pub const json_field_names = .{
        .prefixed_with_source_cluster_alias = "PREFIXED_WITH_SOURCE_CLUSTER_ALIAS",
        .identical = "IDENTICAL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .prefixed_with_source_cluster_alias => "PREFIXED_WITH_SOURCE_CLUSTER_ALIAS",
            .identical => "IDENTICAL",
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
