const std = @import("std");

/// The tier upgrade status of a notify configuration.
///
/// * `BASIC` - Currently at basic tier.
/// * `PENDING_UPGRADE` - Upgrade to advanced tier is pending.
/// * `ADVANCED` - Currently at advanced tier.
/// * `REJECTED` - Tier upgrade was rejected.
pub const TierUpgradeStatus = enum {
    basic,
    pending_upgrade,
    advanced,
    rejected,

    pub const json_field_names = .{
        .basic = "BASIC",
        .pending_upgrade = "PENDING_UPGRADE",
        .advanced = "ADVANCED",
        .rejected = "REJECTED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .basic => "BASIC",
            .pending_upgrade => "PENDING_UPGRADE",
            .advanced => "ADVANCED",
            .rejected => "REJECTED",
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
