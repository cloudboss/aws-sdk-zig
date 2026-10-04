const std = @import("std");

/// The current state of a partner qualifications association. Valid values:
/// `ASSOCIATED` (the partner is associated with a primary), `NOT_ASSOCIATED`
/// (the partner has no active association).
pub const QualificationsAssociationStatus = enum {
    associated,
    not_associated,

    pub const json_field_names = .{
        .associated = "ASSOCIATED",
        .not_associated = "NOT_ASSOCIATED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .associated => "ASSOCIATED",
            .not_associated => "NOT_ASSOCIATED",
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
