const aws = @import("aws");

/// Source server in staging account that extended source server connected to.
pub const StagingSourceServer = struct {
    /// The ARN of the source server.
    arn: ?[]const u8 = null,

    /// Hostname of staging source server.
    hostname: ?[]const u8 = null,

    /// A list of tags associated with the staging source server.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "arn",
        .hostname = "hostname",
        .tags = "tags",
    };
};
