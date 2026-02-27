/// A storage location for invocation logs.
pub const InvocationLogSource = union(enum) {
    /// The URI of an invocation log in a bucket.
    s_3_uri: ?[]const u8,

    pub const json_field_names = .{
        .s_3_uri = "s3Uri",
    };
};
