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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
