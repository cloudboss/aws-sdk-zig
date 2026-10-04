const std = @import("std");

/// Specifies how Amazon Macie found the sensitive data that produced a finding.
/// Possible values are:
pub const OriginType = enum {
    sensitive_data_discovery_job,
    automated_sensitive_data_discovery,

    pub const json_field_names = .{
        .sensitive_data_discovery_job = "SENSITIVE_DATA_DISCOVERY_JOB",
        .automated_sensitive_data_discovery = "AUTOMATED_SENSITIVE_DATA_DISCOVERY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sensitive_data_discovery_job => "SENSITIVE_DATA_DISCOVERY_JOB",
            .automated_sensitive_data_discovery => "AUTOMATED_SENSITIVE_DATA_DISCOVERY",
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
