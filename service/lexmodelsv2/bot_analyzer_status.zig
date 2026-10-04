const std = @import("std");

/// The status of the bot analysis execution.
///
/// Valid values include:
///
/// * `Processing`
///
/// * `Available`
///
/// * `Failed`
///
/// * `Stopping`
///
/// * `Stopped`
pub const BotAnalyzerStatus = enum {
    processing,
    available,
    failed,
    stopping,
    stopped,

    pub const json_field_names = .{
        .processing = "Processing",
        .available = "Available",
        .failed = "Failed",
        .stopping = "Stopping",
        .stopped = "Stopped",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .processing => "Processing",
            .available => "Available",
            .failed => "Failed",
            .stopping => "Stopping",
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
