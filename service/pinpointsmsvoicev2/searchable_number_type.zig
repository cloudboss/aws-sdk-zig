const std = @import("std");

/// The type of phone number to search for with ListAvailablePhoneNumbers.
/// Currently only TEN_DLC is supported; additional number types (for example
/// TOLL_FREE) will be added in future phases. Modeled as a dedicated enum
/// rather
/// than RequestableNumberType so this operation advertises only the values it
/// actually supports. New values may be added over time (backward compatible).
pub const SearchableNumberType = enum {
    ten_dlc,

    pub const json_field_names = .{
        .ten_dlc = "TEN_DLC",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ten_dlc => "TEN_DLC",
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
