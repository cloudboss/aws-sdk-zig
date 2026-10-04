const std = @import("std");

/// The enablement status of a CSPM connector. Indicates the lifecycle state of
/// the connector resource.
pub const CspmEnablementStatus = enum {
    enabled,
    pending_enablement,
    pending_update,
    pending_deletion,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .pending_enablement = "PENDING_ENABLEMENT",
        .pending_update = "PENDING_UPDATE",
        .pending_deletion = "PENDING_DELETION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .enabled => "ENABLED",
            .pending_enablement => "PENDING_ENABLEMENT",
            .pending_update => "PENDING_UPDATE",
            .pending_deletion => "PENDING_DELETION",
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
