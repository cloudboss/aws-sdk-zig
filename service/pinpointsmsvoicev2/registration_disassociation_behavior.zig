const std = @import("std");

pub const RegistrationDisassociationBehavior = enum {
    disassociate_all_closes_registration,
    disassociate_all_allows_delete_registration,
    delete_registration_disassociates,

    pub const json_field_names = .{
        .disassociate_all_closes_registration = "DISASSOCIATE_ALL_CLOSES_REGISTRATION",
        .disassociate_all_allows_delete_registration = "DISASSOCIATE_ALL_ALLOWS_DELETE_REGISTRATION",
        .delete_registration_disassociates = "DELETE_REGISTRATION_DISASSOCIATES",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .disassociate_all_closes_registration => "DISASSOCIATE_ALL_CLOSES_REGISTRATION",
            .disassociate_all_allows_delete_registration => "DISASSOCIATE_ALL_ALLOWS_DELETE_REGISTRATION",
            .delete_registration_disassociates => "DELETE_REGISTRATION_DISASSOCIATES",
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
