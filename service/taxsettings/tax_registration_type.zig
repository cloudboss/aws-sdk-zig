const std = @import("std");

pub const TaxRegistrationType = enum {
    vat,
    gst,
    cpf,
    cnpj,
    sst,
    tin,
    nric,

    pub const json_field_names = .{
        .vat = "VAT",
        .gst = "GST",
        .cpf = "CPF",
        .cnpj = "CNPJ",
        .sst = "SST",
        .tin = "TIN",
        .nric = "NRIC",
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
