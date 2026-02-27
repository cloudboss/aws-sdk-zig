/// A revision for an Lambda deployment that is a YAML-formatted or
/// JSON-formatted string. For Lambda deployments, the revision is the same
/// as the AppSpec file.
pub const RawString = struct {
    /// The YAML-formatted or JSON-formatted revision string. It includes
    /// information about
    /// which Lambda function to update and optional Lambda functions
    /// that validate deployment lifecycle events.
    content: ?[]const u8,

    /// The SHA256 hash value of the revision content.
    sha_256: ?[]const u8,

    pub const json_field_names = .{
        .content = "content",
        .sha_256 = "sha256",
    };
};
