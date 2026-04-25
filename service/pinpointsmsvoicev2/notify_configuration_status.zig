const std = @import("std");

/// The status of a notify configuration.
///
/// * `PENDING` - The notify configuration is pending review.
/// * `ACTIVE` - The notify configuration is active and can be used.
/// * `REJECTED` - The notify configuration was rejected.
/// * `REQUIRES_VERIFICATION` - The notify configuration requires verification.
pub const NotifyConfigurationStatus = enum {
    pending,
    active,
    rejected,
    requires_verification,

    pub const json_field_names = .{
        .pending = "PENDING",
        .active = "ACTIVE",
        .rejected = "REJECTED",
        .requires_verification = "REQUIRES_VERIFICATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .active => "ACTIVE",
            .rejected => "REJECTED",
            .requires_verification => "REQUIRES_VERIFICATION",
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
