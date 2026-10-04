/// The timeout settings for ad decision server interactions during ad
/// personalization.
pub const AdsPersonalizationTimeouts = struct {
    /// The maximum time, in milliseconds, that MediaTailor waits for a single ad
    /// decision server response during live or VOD playback. The default is 3000.
    ads_request_timeout_milliseconds: ?i32 = null,

    /// The maximum total time, in milliseconds, that MediaTailor spends on ad
    /// decision server activity for live manifests, including making requests,
    /// waiting for responses, and following VAST wrapper redirects. The default is
    /// 10000.
    live_maximum_ads_personalization_time_milliseconds: ?i32 = null,

    /// The maximum time, in milliseconds, that MediaTailor waits for a single ad
    /// decision server response during prefetch retrieval. If not set, the value of
    /// AdsRequestTimeoutMilliseconds is used.
    prefetch_ads_request_timeout_milliseconds: ?i32 = null,

    /// The maximum total time, in milliseconds, that MediaTailor spends on ad
    /// decision server activity during prefetch retrieval, including making
    /// requests, waiting for responses, and following VAST wrapper redirects.
    prefetch_maximum_ads_personalization_time_milliseconds: ?i32 = null,

    /// The maximum total time, in milliseconds, that MediaTailor spends on ad
    /// decision server activity for VOD manifests, including making requests,
    /// waiting for responses, and following VAST wrapper redirects. The default is
    /// 10000.
    vod_maximum_ads_personalization_time_milliseconds: ?i32 = null,

    pub const json_field_names = .{
        .ads_request_timeout_milliseconds = "AdsRequestTimeoutMilliseconds",
        .live_maximum_ads_personalization_time_milliseconds = "LiveMaximumAdsPersonalizationTimeMilliseconds",
        .prefetch_ads_request_timeout_milliseconds = "PrefetchAdsRequestTimeoutMilliseconds",
        .prefetch_maximum_ads_personalization_time_milliseconds = "PrefetchMaximumAdsPersonalizationTimeMilliseconds",
        .vod_maximum_ads_personalization_time_milliseconds = "VodMaximumAdsPersonalizationTimeMilliseconds",
    };
};
