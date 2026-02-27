const MatchRange = @import("match_range.zig").MatchRange;

/// An object that represents the method and value to match with the header
/// value sent in a
/// request. Specify one match method.
pub const HeaderMatchMethod = union(enum) {
    /// The value sent by the client must match the specified value exactly.
    exact: ?[]const u8,
    /// The value sent by the client must begin with the specified characters.
    prefix: ?[]const u8,
    /// An object that represents the range of values to match on.
    range: ?MatchRange,
    /// The value sent by the client must include the specified characters.
    regex: ?[]const u8,
    /// The value sent by the client must end with the specified characters.
    suffix: ?[]const u8,

    pub const json_field_names = .{
        .exact = "exact",
        .prefix = "prefix",
        .range = "range",
        .regex = "regex",
        .suffix = "suffix",
    };
};
