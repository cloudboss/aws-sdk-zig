/// The configuration used to authenticate a speaker during a session.
pub const AuthenticationConfiguration = struct {
    /// The minimum threshold needed to successfully authenticate a speaker.
    acceptance_threshold: i32,

    pub const json_field_names = .{
        .acceptance_threshold = "AcceptanceThreshold",
    };
};
