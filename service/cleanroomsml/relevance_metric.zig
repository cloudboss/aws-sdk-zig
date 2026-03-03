const AudienceSize = @import("audience_size.zig").AudienceSize;

/// The relevance score of a generated audience.
pub const RelevanceMetric = struct {
    audience_size: AudienceSize,

    /// The relevance score of the generated audience.
    score: ?f64 = null,

    pub const json_field_names = .{
        .audience_size = "audienceSize",
        .score = "score",
    };
};
