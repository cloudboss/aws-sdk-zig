/// The configuration for using a content delivery network (CDN), like Amazon
/// CloudFront, for content and ad segment management.
pub const CdnConfiguration = struct {
    /// A non-default content delivery network (CDN) to serve ad segments. By
    /// default, AWS Elemental MediaTailor uses Amazon CloudFront with default cache
    /// settings as its CDN for ad segments. To set up an alternate CDN, create a
    /// rule in your CDN for the origin ads.mediatailor.*<region>*.amazonaws.com.
    /// Then specify the rule's name in this `AdSegmentUrlPrefix`. When AWS
    /// Elemental MediaTailor serves a manifest, it reports your CDN as the source
    /// for ad segments.
    ad_segment_url_prefix: ?[]const u8 = null,

    /// A content delivery network (CDN) to cache content segments, so that content
    /// requests don’t always have to go to the origin server. First, create a rule
    /// in your CDN for the content segment origin server. Then specify the rule's
    /// name in this `ContentSegmentUrlPrefix`. When AWS Elemental MediaTailor
    /// serves a manifest, it reports your CDN as the source for content segments.
    content_segment_url_prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .ad_segment_url_prefix = "AdSegmentUrlPrefix",
        .content_segment_url_prefix = "ContentSegmentUrlPrefix",
    };
};
