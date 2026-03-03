const std = @import("std");

/// The time granularity for aggregating the cost efficiency metrics.
pub const GranularityType = enum {
    /// Metrics are aggregated daily, with each data point representing a single
    /// day's worth of efficiency data. Timestamps are formatted as YYYY-MM-DD.
    daily,
    /// Metrics are aggregated monthly, with each data point representing a full
    /// month's worth of efficiency data. Timestamps are formatted as YYYY-MM.
    monthly,

    pub const json_field_names = .{
        .daily = "Daily",
        .monthly = "Monthly",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .daily => "Daily",
            .monthly => "Monthly",
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
