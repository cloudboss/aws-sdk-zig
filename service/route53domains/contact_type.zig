const std = @import("std");

pub const ContactType = enum {
    person,
    company,
    association,
    public_body,
    reseller,

    pub const json_field_names = .{
        .person = "PERSON",
        .company = "COMPANY",
        .association = "ASSOCIATION",
        .public_body = "PUBLIC_BODY",
        .reseller = "RESELLER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .person => "PERSON",
            .company => "COMPANY",
            .association => "ASSOCIATION",
            .public_body => "PUBLIC_BODY",
            .reseller => "RESELLER",
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
