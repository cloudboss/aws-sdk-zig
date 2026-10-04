const std = @import("std");

pub const TaxRegistrationType = enum {
    vat,
    gst,
    cpf,
    cnpj,
    sst,
    tin,
    nric,
    pan,
    nip,

    pub const json_field_names = .{
        .vat = "VAT",
        .gst = "GST",
        .cpf = "CPF",
        .cnpj = "CNPJ",
        .sst = "SST",
        .tin = "TIN",
        .nric = "NRIC",
        .pan = "PAN",
        .nip = "NIP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .vat => "VAT",
            .gst => "GST",
            .cpf => "CPF",
            .cnpj => "CNPJ",
            .sst => "SST",
            .tin => "TIN",
            .nric => "NRIC",
            .pan => "PAN",
            .nip => "NIP",
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
