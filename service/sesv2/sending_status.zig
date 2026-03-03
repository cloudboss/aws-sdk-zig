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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
