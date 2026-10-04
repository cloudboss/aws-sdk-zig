const std = @import("std");

/// The sending status for a reputation entity. This can be one of the
/// following:
///
/// * `ENABLED` – Sending is allowed for this entity.
///
/// * `DISABLED` – Sending is prevented for this entity.
///
/// * `REINSTATED` – Sending is allowed even if there are active reputation
///   findings.
pub const SendingStatus = enum {
    enabled,
    reinstated,
    disabled,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .reinstated = "REINSTATED",
        .disabled = "DISABLED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .enabled => "ENABLED",
            .reinstated => "REINSTATED",
            .disabled => "DISABLED",
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
