const aws = @import("aws");

/// Summary information about a PlaybackRestrictionPolicy.
pub const PlaybackRestrictionPolicySummary = struct {
    /// A list of country codes that control geoblocking restriction. Allowed values
    /// are the
    /// officially assigned [ISO 3166-1
    /// alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) codes. Default:
    /// All countries (an empty array).
    allowed_countries: []const []const u8,

    /// A list of origin sites that control CORS restriction. Allowed values are the
    /// same as valid
    /// values of the Origin header defined at
    /// [https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Origin](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Origin). Default: All
    /// origins (an empty array).
    allowed_origins: []const []const u8,

    /// Playback-restriction-policy ARN
    arn: []const u8,

    /// Whether channel playback is constrained by origin site. Default:
    /// `false`.
    enable_strict_origin_enforcement: ?bool,

    /// Playback-restriction-policy name. The value does not need to be unique.
    name: ?[]const u8,

    /// Tags attached to the resource. Array of 1-50 maps, each of the form
    /// `string:string
    /// (key:value)`. See [Best practices and
    /// strategies](https://docs.aws.amazon.com/tag-editor/latest/userguide/best-practices-and-strats.html) in *Tagging Amazon Web Services Resources and Tag Editor* for details, including restrictions that apply to tags and "Tag naming limits and requirements"; Amazon IVS has no
    /// service-specific constraints beyond what is documented there.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .allowed_countries = "allowedCountries",
        .allowed_origins = "allowedOrigins",
        .arn = "arn",
        .enable_strict_origin_enforcement = "enableStrictOriginEnforcement",
        .name = "name",
        .tags = "tags",
    };
};
