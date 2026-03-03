const std = @import("std");

pub const CustomMetricType = enum {
    string_list,
    ip_address_list,
    number_list,
    number,

    pub const json_field_names = .{
        .string_list = "string-list",
        .ip_address_list = "ip-address-list",
        .number_list = "number-list",
        .number = "number",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .string_list => "string-list",
            .ip_address_list => "ip-address-list",
            .number_list => "number-list",
            .number => "number",
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
