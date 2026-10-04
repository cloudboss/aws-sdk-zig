const std = @import("std");

pub const PostalCodeMode = enum {
    merge_all_spanned_localities,
    enumerate_spanned_localities,
    enumerate_spanned_districts,

    pub const json_field_names = .{
        .merge_all_spanned_localities = "MergeAllSpannedLocalities",
        .enumerate_spanned_localities = "EnumerateSpannedLocalities",
        .enumerate_spanned_districts = "EnumerateSpannedDistricts",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .merge_all_spanned_localities => "MergeAllSpannedLocalities",
            .enumerate_spanned_localities => "EnumerateSpannedLocalities",
            .enumerate_spanned_districts => "EnumerateSpannedDistricts",
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
