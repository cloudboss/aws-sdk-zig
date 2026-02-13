const aws = @import("aws");

/// The OpsData summary.
pub const OpsEntityItem = struct {
    /// The time the OpsData was captured.
    capture_time: ?[]const u8,

    /// The details of an OpsData summary.
    content: ?[]const []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .capture_time = "CaptureTime",
        .content = "Content",
    };
};
