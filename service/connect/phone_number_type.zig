const std = @import("std");

pub const PhoneNumberType = enum {
    toll_free,
    did,
    uifn,
    shared,
    third_party_tf,
    third_party_did,
    short_code,

    pub const json_field_names = .{
        .toll_free = "TOLL_FREE",
        .did = "DID",
        .uifn = "UIFN",
        .shared = "SHARED",
        .third_party_tf = "THIRD_PARTY_TF",
        .third_party_did = "THIRD_PARTY_DID",
        .short_code = "SHORT_CODE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .toll_free => "TOLL_FREE",
            .did => "DID",
            .uifn => "UIFN",
            .shared => "SHARED",
            .third_party_tf => "THIRD_PARTY_TF",
            .third_party_did => "THIRD_PARTY_DID",
            .short_code => "SHORT_CODE",
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
