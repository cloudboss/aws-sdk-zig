const std = @import("std");

/// The behavior when a node lifecycle script fails. Valid values:
///
/// * `TERMINATE` – Terminates the compute node.
/// * `STOP_SEQUENCE` – Stops running subsequent scripts in the sequence but
///   doesn't terminate the compute node.
/// * `CONTINUE` – Ignores the error and continues running the next script.
pub const OnError = enum {
    terminate,
    stop_sequence,
    @"continue",

    pub const json_field_names = .{
        .terminate = "TERMINATE",
        .stop_sequence = "STOP_SEQUENCE",
        .@"continue" = "CONTINUE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .terminate => "TERMINATE",
            .stop_sequence => "STOP_SEQUENCE",
            .@"continue" => "CONTINUE",
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
