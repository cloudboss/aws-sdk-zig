const Location = @import("location.zig").Location;

/// The data source for the dataset.
pub const Source = struct {
    /// Contains the ARN of the dataset. If the source is Kendra, it's the ARN of
    /// the Kendra index.
    arn: ?[]const u8 = null,

    /// Contains the location information where the cited text is originally stored.
    /// For example, if the data source is Kendra, and the text synchronized is from
    /// an S3 bucket, then the location refers to an S3 object.
    location: ?Location = null,

    pub const json_field_names = .{
        .arn = "arn",
        .location = "location",
    };
};
