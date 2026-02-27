/// The S3 destination source configuration.
pub const S3SourceConfiguration = struct {
    /// The S3 destination source configuration location.
    location: []const u8,

    pub const json_field_names = .{
        .location = "location",
    };
};
