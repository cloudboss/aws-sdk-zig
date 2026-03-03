const std = @import("std");

pub const ContactHandlingScope = enum {
    cross_contacts,
    per_contact,

    pub const json_field_names = .{
        .cross_contacts = "CROSS_CONTACTS",
        .per_contact = "PER_CONTACT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cross_contacts => "CROSS_CONTACTS",
            .per_contact => "PER_CONTACT",
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
