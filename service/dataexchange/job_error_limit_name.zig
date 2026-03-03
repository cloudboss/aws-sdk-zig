const std = @import("std");

pub const JobErrorLimitName = enum {
    assets_per_revision,
    asset_size_in_gb,
    amazon_redshift_datashare_assets_per_revision,
    aws_lake_formation_data_permission_assets_per_revision,
    amazon_s3_data_access_assets_per_revision,

    pub const json_field_names = .{
        .assets_per_revision = "Assets per revision",
        .asset_size_in_gb = "Asset size in GB",
        .amazon_redshift_datashare_assets_per_revision = "Amazon Redshift datashare assets per revision",
        .aws_lake_formation_data_permission_assets_per_revision = "AWS Lake Formation data permission assets per revision",
        .amazon_s3_data_access_assets_per_revision = "Amazon S3 data access assets per revision",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .assets_per_revision => "Assets per revision",
            .asset_size_in_gb => "Asset size in GB",
            .amazon_redshift_datashare_assets_per_revision => "Amazon Redshift datashare assets per revision",
            .aws_lake_formation_data_permission_assets_per_revision => "AWS Lake Formation data permission assets per revision",
            .amazon_s3_data_access_assets_per_revision => "Amazon S3 data access assets per revision",
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
