/// The Amazon S3 properties of a connection.
pub const S3PropertiesInput = struct {
    /// The Amazon S3 Access Grant location ID that's part of the Amazon S3
    /// properties of a connection.
    s_3_access_grant_location_id: ?[]const u8 = null,

    /// The Amazon S3 URI that's part of the Amazon S3 properties of a connection.
    s_3_uri: []const u8,

    pub const json_field_names = .{
        .s_3_access_grant_location_id = "s3AccessGrantLocationId",
        .s_3_uri = "s3Uri",
    };
};
