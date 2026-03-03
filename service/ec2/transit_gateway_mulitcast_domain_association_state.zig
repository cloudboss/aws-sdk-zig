const std = @import("std");

pub const TransitGatewayMulitcastDomainAssociationState = enum {
    pending_acceptance,
    associating,
    associated,
    disassociating,
    disassociated,
    rejected,
    failed,

    pub const json_field_names = .{
        .pending_acceptance = "pendingAcceptance",
        .associating = "associating",
        .associated = "associated",
        .disassociating = "disassociating",
        .disassociated = "disassociated",
        .rejected = "rejected",
        .failed = "failed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending_acceptance => "pendingAcceptance",
            .associating => "associating",
            .associated => "associated",
            .disassociating => "disassociating",
            .disassociated => "disassociated",
            .rejected => "rejected",
            .failed => "failed",
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
