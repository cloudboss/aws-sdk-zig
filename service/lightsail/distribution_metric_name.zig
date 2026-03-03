const std = @import("std");

pub const DistributionMetricName = enum {
    requests,
    bytes_downloaded,
    bytes_uploaded,
    total_error_rate,
    http_4_xx_error_rate,
    http_5_xx_error_rate,

    pub const json_field_names = .{
        .requests = "Requests",
        .bytes_downloaded = "BytesDownloaded",
        .bytes_uploaded = "BytesUploaded",
        .total_error_rate = "TotalErrorRate",
        .http_4_xx_error_rate = "Http4xxErrorRate",
        .http_5_xx_error_rate = "Http5xxErrorRate",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .requests => "Requests",
            .bytes_downloaded => "BytesDownloaded",
            .bytes_uploaded => "BytesUploaded",
            .total_error_rate => "TotalErrorRate",
            .http_4_xx_error_rate => "Http4xxErrorRate",
            .http_5_xx_error_rate => "Http5xxErrorRate",
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
