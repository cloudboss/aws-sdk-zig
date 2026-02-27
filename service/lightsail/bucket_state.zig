/// Describes the state of an Amazon Lightsail bucket.
pub const BucketState = struct {
    /// The state code of the bucket.
    ///
    /// The following codes are possible:
    ///
    /// * `OK` - The bucket is in a running state.
    ///
    /// * `Unknown` - Creation of the bucket might have timed-out. You might want to
    /// delete the bucket and create a new one.
    code: ?[]const u8,

    /// A message that describes the state of the bucket.
    message: ?[]const u8,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
    };
};
