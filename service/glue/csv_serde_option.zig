const std = @import("std");

pub const CsvSerdeOption = enum {
    open_csv_ser_de,
    lazy_simple_ser_de,
    none,

    pub const json_field_names = .{
        .open_csv_ser_de = "OpenCSVSerDe",
        .lazy_simple_ser_de = "LazySimpleSerDe",
        .none = "None",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .open_csv_ser_de => "OpenCSVSerDe",
            .lazy_simple_ser_de => "LazySimpleSerDe",
            .none => "None",
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
