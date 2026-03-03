const std = @import("std");

/// Specifies whether automated sensitive data discovery is currently configured
/// to analyze objects in an S3 bucket. Possible values are:
pub const AutomatedDiscoveryMonitoringStatus = enum {
    monitored,
    not_monitored,

    pub const json_field_names = .{
        .monitored = "MONITORED",
        .not_monitored = "NOT_MONITORED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .monitored => "MONITORED",
            .not_monitored => "NOT_MONITORED",
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
