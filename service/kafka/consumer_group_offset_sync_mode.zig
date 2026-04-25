const std = @import("std");

/// The consumer group offset synchronization mode. With LEGACY, offsets are
/// synchronized when producers write to the source cluster. With ENHANCED,
/// consumer offsets are synchronized regardless of producer location. ENHANCED
/// requires a corresponding replicator that replicates data from the target
/// cluster to the source cluster.
pub const ConsumerGroupOffsetSyncMode = enum {
    legacy,
    enhanced,

    pub const json_field_names = .{
        .legacy = "LEGACY",
        .enhanced = "ENHANCED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .legacy => "LEGACY",
            .enhanced => "ENHANCED",
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
