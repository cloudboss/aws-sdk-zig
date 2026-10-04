const LimitEntry = @import("limit_entry.zig").LimitEntry;

/// A rate limit definition within a batch put request. If you provide a
/// `rateLimitId`, the service uses it for upsert matching against existing rate
/// limits.
pub const BatchPutLimitEntry = struct {
    /// An optional human-readable description for this rate limit. If not provided,
    /// the rate limit is created without a description.
    description: ?[]const u8 = null,

    /// The ordered list of dimension key names that define the scope of this rate
    /// limit.
    dimension_keys: []const []const u8,

    /// The list of rule entries that map dimension values to rate configurations.
    entries: []const LimitEntry,

    /// The unique identifier of the rate limit. If provided, the service uses it
    /// for upsert matching against existing rate limits.
    rate_limit_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "description",
        .dimension_keys = "dimensionKeys",
        .entries = "entries",
        .rate_limit_id = "rateLimitId",
    };
};
