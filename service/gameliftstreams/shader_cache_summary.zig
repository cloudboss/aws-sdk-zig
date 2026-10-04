const ShaderCacheStatus = @import("shader_cache_status.zig").ShaderCacheStatus;

/// Describes a shader cache associated with an Amazon GameLift Streams
/// application.
pub const ShaderCacheSummary = struct {
    /// An [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html)
    /// that uniquely identifies the application resource. Example ARN:
    /// `arn:aws:gameliftstreams:us-west-2:111122223333:application/a-9ZY8X7Wv6`.
    application_arn: []const u8,

    /// The stream groups compatible with this shader cache. Compatibility is based
    /// on GPU type and GPU driver version. For more information on shader cache
    /// compatibility, see [Shader
    /// caches](https://docs.aws.amazon.com/gameliftstreams/latest/developerguide/shader-caches.html) in the *Amazon GameLift Streams Developer Guide*.
    ///
    /// This value is a set of [Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html) that uniquely identify stream group resources. Example ARN: `arn:aws:gameliftstreams:us-west-2:111122223333:streamgroup/sg-1AB2C3De4`.
    associated_stream_groups: ?[]const []const u8 = null,

    /// A unique identifier for the shader cache, formatted as a 32-character
    /// hexadecimal string. Format is `1271e693c50b940e228582f1ccdd4e27`.
    identifier: []const u8,

    /// A timestamp that indicates when this resource was last updated. Timestamps
    /// are expressed using in ISO8601 format, such as: `2022-12-27T22:29:40+00:00`
    /// (UTC).
    last_updated_at: ?i64 = null,

    /// The current status of the shader cache. Possible statuses include the
    /// following:
    ///
    /// * `INITIALIZED`: Amazon GameLift Streams received the request and is
    ///   preparing the shader cache.
    /// * `PROCESSING`: Amazon GameLift Streams is replicating the shader cache to
    ///   the streaming locations in the associated stream groups.
    /// * `READY`: The shader cache is replicated and available for use in stream
    ///   sessions.
    /// * `DELETING`: Amazon GameLift Streams is deleting the shader cache.
    /// * `ERROR`: An error occurred during shader cache processing. Create a new
    ///   shader cache to try again.
    status: ?ShaderCacheStatus = null,

    /// The total storage used by all compiled shader files in this shader cache, in
    /// bytes.
    storage_bytes: ?i64 = null,

    pub const json_field_names = .{
        .application_arn = "ApplicationArn",
        .associated_stream_groups = "AssociatedStreamGroups",
        .identifier = "Identifier",
        .last_updated_at = "LastUpdatedAt",
        .status = "Status",
        .storage_bytes = "StorageBytes",
    };
};
