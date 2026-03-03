const std = @import("std");

pub const AsnAssociationState = enum {
    disassociated,
    failed_disassociation,
    failed_association,
    pending_disassociation,
    pending_association,
    associated,

    pub const json_field_names = .{
        .disassociated = "disassociated",
        .failed_disassociation = "failed-disassociation",
        .failed_association = "failed-association",
        .pending_disassociation = "pending-disassociation",
        .pending_association = "pending-association",
        .associated = "associated",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .disassociated => "disassociated",
            .failed_disassociation => "failed-disassociation",
            .failed_association => "failed-association",
            .pending_disassociation => "pending-disassociation",
            .pending_association => "pending-association",
            .associated => "associated",
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
