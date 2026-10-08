const std = @import("std");

/// The action to perform on an integration's webhook.
pub const WebhookAction = enum {
    /// Create the webhook if one does not already exist. Returns the payload URL
    /// and the signing secret.
    create_if_absent,
    /// Generate a new signing secret for the existing webhook, keeping the same
    /// payload URL. Returns the new secret.
    rotate,

    pub const json_field_names = .{
        .create_if_absent = "CREATE_IF_ABSENT",
        .rotate = "ROTATE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .create_if_absent => "CREATE_IF_ABSENT",
            .rotate => "ROTATE",
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
