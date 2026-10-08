const CacheConfigType = @import("cache_config_type.zig").CacheConfigType;

/// Describes the cache configuration for an Amplify app.
///
/// For more information about how Amplify applies an optimal cache
/// configuration for your app based on the type of content that is being
/// served, see [Managing cache
/// configuration](https://docs.aws.amazon.com/amplify/latest/userguide/managing-cache-configuration) in the *Amplify User
/// guide*.
pub const CacheConfig = struct {
    /// The type of cache configuration to use for an Amplify app.
    ///
    /// The `AMPLIFY_MANAGED` cache configuration automatically applies an
    /// optimized cache configuration for your app based on its platform, routing
    /// rules, and
    /// rewrite rules.
    ///
    /// The `AMPLIFY_MANAGED_NO_COOKIES` cache configuration type is the same as
    /// `AMPLIFY_MANAGED`, except that it excludes all cookies from the cache
    /// key. This is the default setting.
    type: CacheConfigType,

    pub const json_field_names = .{
        .type = "type",
    };
};
