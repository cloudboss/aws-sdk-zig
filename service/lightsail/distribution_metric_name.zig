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
};
