const std = @import("std");

pub const AssociationStatus = enum {
    not_associated,
    associated_with_owner_account,
    associated_with_shared_account,
    pending_association,
    pending_disassociation,

    pub const json_field_names = .{
        .not_associated = "NOT_ASSOCIATED",
        .associated_with_owner_account = "ASSOCIATED_WITH_OWNER_ACCOUNT",
        .associated_with_shared_account = "ASSOCIATED_WITH_SHARED_ACCOUNT",
        .pending_association = "PENDING_ASSOCIATION",
        .pending_disassociation = "PENDING_DISASSOCIATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .not_associated => "NOT_ASSOCIATED",
            .associated_with_owner_account => "ASSOCIATED_WITH_OWNER_ACCOUNT",
            .associated_with_shared_account => "ASSOCIATED_WITH_SHARED_ACCOUNT",
            .pending_association => "PENDING_ASSOCIATION",
            .pending_disassociation => "PENDING_DISASSOCIATION",
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
