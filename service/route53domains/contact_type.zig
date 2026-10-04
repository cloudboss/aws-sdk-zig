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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
