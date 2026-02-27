/// The object that contains a path format that will be applied when
/// Amazon Lex reads the transcript file in the bucket you provide. Specify this
/// object if you only want Lex to read a subset of files in your Amazon S3
/// bucket.
pub const PathFormat = struct {
    /// A list of Amazon S3 prefixes that points to sub-folders in the Amazon S3
    /// bucket. Specify this list if you only want Lex to read the files under
    /// this set of sub-folders.
    object_prefixes: ?[]const []const u8,

    pub const json_field_names = .{
        .object_prefixes = "objectPrefixes",
    };
};
