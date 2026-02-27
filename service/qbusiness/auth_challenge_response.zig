const aws = @import("aws");

/// Contains details of the authentication information received from a third
/// party authentication server in response to an authentication challenge.
pub const AuthChallengeResponse = struct {
    /// The mapping of key-value pairs in an authentication challenge response.
    response_map: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .response_map = "responseMap",
    };
};
