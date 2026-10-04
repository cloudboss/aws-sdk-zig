/// The concurrency settings for ad decision server interactions during ad
/// personalization.
pub const AdsPersonalizationConcurrency = struct {
    /// Enables parallel processing of ad decision server requests in VOD workflows
    /// when the ADS returns VAST responses. The default is false.
    enable_vod_vast_parallelization: ?bool = null,

    /// The maximum number of simultaneous requests that MediaTailor makes to the ad
    /// decision server per manifest request. The default is 1.
    max_concurrent_ads_requests: ?i32 = null,

    pub const json_field_names = .{
        .enable_vod_vast_parallelization = "EnableVodVastParallelization",
        .max_concurrent_ads_requests = "MaxConcurrentAdsRequests",
    };
};
