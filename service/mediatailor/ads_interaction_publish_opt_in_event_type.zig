const std = @import("std");

/// An ADS interaction log event type that MediaTailor emits only when you opt
/// in to it. For descriptions of each event type, see [MediaTailor ADS logs
/// description and event
/// types](https://docs.aws.amazon.com/mediatailor/latest/ug/ads-log-format.html) in Elemental MediaTailor User Guide.
pub const AdsInteractionPublishOptInEventType = enum {
    raw_ads_response,
    raw_ads_request,
    raw_bid_request,
    raw_bid_response,
    pre_ads_request_hook_summary,
    pre_ads_request_function_completed,
    post_ads_response_hook_summary,
    post_ads_response_function_completed,
    pre_manifest_insertion_hook_summary,
    pre_manifest_insertion_function_completed,

    pub const json_field_names = .{
        .raw_ads_response = "RAW_ADS_RESPONSE",
        .raw_ads_request = "RAW_ADS_REQUEST",
        .raw_bid_request = "RAW_BID_REQUEST",
        .raw_bid_response = "RAW_BID_RESPONSE",
        .pre_ads_request_hook_summary = "PRE_ADS_REQUEST_HOOK_SUMMARY",
        .pre_ads_request_function_completed = "PRE_ADS_REQUEST_FUNCTION_COMPLETED",
        .post_ads_response_hook_summary = "POST_ADS_RESPONSE_HOOK_SUMMARY",
        .post_ads_response_function_completed = "POST_ADS_RESPONSE_FUNCTION_COMPLETED",
        .pre_manifest_insertion_hook_summary = "PRE_MANIFEST_INSERTION_HOOK_SUMMARY",
        .pre_manifest_insertion_function_completed = "PRE_MANIFEST_INSERTION_FUNCTION_COMPLETED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .raw_ads_response => "RAW_ADS_RESPONSE",
            .raw_ads_request => "RAW_ADS_REQUEST",
            .raw_bid_request => "RAW_BID_REQUEST",
            .raw_bid_response => "RAW_BID_RESPONSE",
            .pre_ads_request_hook_summary => "PRE_ADS_REQUEST_HOOK_SUMMARY",
            .pre_ads_request_function_completed => "PRE_ADS_REQUEST_FUNCTION_COMPLETED",
            .post_ads_response_hook_summary => "POST_ADS_RESPONSE_HOOK_SUMMARY",
            .post_ads_response_function_completed => "POST_ADS_RESPONSE_FUNCTION_COMPLETED",
            .pre_manifest_insertion_hook_summary => "PRE_MANIFEST_INSERTION_HOOK_SUMMARY",
            .pre_manifest_insertion_function_completed => "PRE_MANIFEST_INSERTION_FUNCTION_COMPLETED",
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
