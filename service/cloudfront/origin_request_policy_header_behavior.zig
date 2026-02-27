pub const OriginRequestPolicyHeaderBehavior = enum {
    none,
    whitelist,
    all_viewer,
    all_viewer_and_whitelist_cloud_front,
    all_except,
};
