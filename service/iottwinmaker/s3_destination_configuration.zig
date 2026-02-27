/// The S3 destination configuration.
pub const S3DestinationConfiguration = struct {
    /// The S3 destination configuration location.
    location: []const u8,

    pub const json_field_names = .{
        .location = "location",
    };
};
