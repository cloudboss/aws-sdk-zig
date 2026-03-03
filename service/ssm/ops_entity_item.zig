const aws = @import("aws");

/// The OpsData summary.
pub const OpsEntityItem = struct {
    /// The time the OpsData was captured.
    capture_time: ?[]const u8 = null,

    /// The details of an OpsData summary.
    content: ?[]const []const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .capture_time = "CaptureTime",
        .content = "Content",
    };
};
