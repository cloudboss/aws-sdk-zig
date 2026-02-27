const aws = @import("aws");

/// An authentication verification event response by a third party
/// authentication server to Amazon Q Business.
pub const AuthChallengeResponseEvent = struct {
    /// The mapping of key-value pairs in an authentication challenge response.
    response_map: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .response_map = "responseMap",
    };
};
