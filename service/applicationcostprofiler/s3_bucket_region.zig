const std = @import("std");

pub const S3BucketRegion = enum {
    ap_east_1,
    me_south_1,
    eu_south_1,
    af_south_1,

    pub const json_field_names = .{
        .ap_east_1 = "ap-east-1",
        .me_south_1 = "me-south-1",
        .eu_south_1 = "eu-south-1",
        .af_south_1 = "af-south-1",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ap_east_1 => "ap-east-1",
            .me_south_1 => "me-south-1",
            .eu_south_1 => "eu-south-1",
            .af_south_1 => "af-south-1",
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
