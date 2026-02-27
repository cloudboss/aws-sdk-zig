const ConnectionStatus = @import("connection_status.zig").ConnectionStatus;

/// The Amazon S3 properties of a connection.
pub const S3PropertiesOutput = struct {
    /// The error message that gets displayed.
    error_message: ?[]const u8,

    /// The Amazon S3 Access Grant location ID that's part of the Amazon S3
    /// properties of a connection.
    s_3_access_grant_location_id: ?[]const u8,

    /// The Amazon S3 URI that's part of the Amazon S3 properties of a connection.
    s_3_uri: []const u8,

    /// The status of the Amazon S3 connection.
    status: ?ConnectionStatus,

    pub const json_field_names = .{
        .error_message = "errorMessage",
        .s_3_access_grant_location_id = "s3AccessGrantLocationId",
        .s_3_uri = "s3Uri",
        .status = "status",
    };
};
