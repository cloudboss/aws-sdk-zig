const MatchRange = @import("match_range.zig").MatchRange;

/// An object representing the method header to be matched.
pub const GrpcMetadataMatchMethod = union(enum) {
    /// The exact method header to be matched on.
    exact: ?[]const u8,
    /// The specified beginning characters of the method header to be matched on.
    prefix: ?[]const u8,
    range: ?MatchRange,
    /// The regex used to match the method header.
    regex: ?[]const u8,
    /// The specified ending characters of the method header to match on.
    suffix: ?[]const u8,

    pub const json_field_names = .{
        .exact = "exact",
        .prefix = "prefix",
        .range = "range",
        .regex = "regex",
        .suffix = "suffix",
    };
};
