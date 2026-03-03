const std = @import("std");

pub const AssetType = enum {
    s3_snapshot,
    redshift_data_share,
    api_gateway_api,
    s3_data_access,
    lake_formation_data_permission,

    pub const json_field_names = .{
        .s3_snapshot = "S3_SNAPSHOT",
        .redshift_data_share = "REDSHIFT_DATA_SHARE",
        .api_gateway_api = "API_GATEWAY_API",
        .s3_data_access = "S3_DATA_ACCESS",
        .lake_formation_data_permission = "LAKE_FORMATION_DATA_PERMISSION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .s3_snapshot => "S3_SNAPSHOT",
            .redshift_data_share => "REDSHIFT_DATA_SHARE",
            .api_gateway_api => "API_GATEWAY_API",
            .s3_data_access => "S3_DATA_ACCESS",
            .lake_formation_data_permission => "LAKE_FORMATION_DATA_PERMISSION",
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
