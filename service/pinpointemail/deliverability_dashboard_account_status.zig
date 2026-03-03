const std = @import("std");

/// The current status of your Deliverability dashboard subscription. If this
/// value is
/// `PENDING_EXPIRATION`, your subscription is scheduled to expire at the end
/// of the current calendar month.
pub const DeliverabilityDashboardAccountStatus = enum {
    active,
    pending_expiration,
    disabled,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .pending_expiration = "PENDING_EXPIRATION",
        .disabled = "DISABLED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .active => "ACTIVE",
            .pending_expiration => "PENDING_EXPIRATION",
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
