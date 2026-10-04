const std = @import("std");

pub const DomainAvailability = enum {
    available,
    available_reserved,
    available_preorder,
    unavailable,
    unavailable_premium,
    unavailable_restricted,
    reserved,
    dont_know,
    invalid_name_for_tld,
    pending,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .available_reserved = "AVAILABLE_RESERVED",
        .available_preorder = "AVAILABLE_PREORDER",
        .unavailable = "UNAVAILABLE",
        .unavailable_premium = "UNAVAILABLE_PREMIUM",
        .unavailable_restricted = "UNAVAILABLE_RESTRICTED",
        .reserved = "RESERVED",
        .dont_know = "DONT_KNOW",
        .invalid_name_for_tld = "INVALID_NAME_FOR_TLD",
        .pending = "PENDING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .available => "AVAILABLE",
            .available_reserved => "AVAILABLE_RESERVED",
            .available_preorder => "AVAILABLE_PREORDER",
            .unavailable => "UNAVAILABLE",
            .unavailable_premium => "UNAVAILABLE_PREMIUM",
            .unavailable_restricted => "UNAVAILABLE_RESTRICTED",
            .reserved => "RESERVED",
            .dont_know => "DONT_KNOW",
            .invalid_name_for_tld => "INVALID_NAME_FOR_TLD",
            .pending => "PENDING",
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
