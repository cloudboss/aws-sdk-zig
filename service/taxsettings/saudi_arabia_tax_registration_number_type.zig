const std = @import("std");

pub const SaudiArabiaTaxRegistrationNumberType = enum {
    tax_registration_number,
    tax_identification_number,
    commercial_registration_number,

    pub const json_field_names = .{
        .tax_registration_number = "TaxRegistrationNumber",
        .tax_identification_number = "TaxIdentificationNumber",
        .commercial_registration_number = "CommercialRegistrationNumber",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .tax_registration_number => "TaxRegistrationNumber",
            .tax_identification_number => "TaxIdentificationNumber",
            .commercial_registration_number => "CommercialRegistrationNumber",
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
