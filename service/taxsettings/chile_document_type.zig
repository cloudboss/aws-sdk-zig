const std = @import("std");

/// The type of tax document for Chile.
pub const ChileDocumentType = enum {
    invoice,
    receipt,

    pub const json_field_names = .{
        .invoice = "Invoice",
        .receipt = "Receipt",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .invoice => "Invoice",
            .receipt => "Receipt",
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
